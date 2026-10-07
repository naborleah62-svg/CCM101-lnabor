# CCM101 - Cloud Computing

## Enterprise Cloud Architect – Operational Manual

**Project:** Secure Multi-Tier Web Application
**Application Stack:** WordPress + MySQL
**Prepared by:** Leah A. Nabor | Maricar J. Valdez | Paula Mae S. Mata | Katrina Mae G. Rimando
**Section:** BSIT 2A
**Instructor:** Jenkielyn C. Torres
**Date:** October 2026

---

## 1. System Overview

This manual explains how to run, secure, and maintain a multi-tier web application using Docker containers on an Ubuntu Server Virtual Machine inside VirtualBox.

### System Components

* **Host Computer:** Windows OS running Oracle VirtualBox
* **Server OS:** Headless Ubuntu Server LTS (24.04 LTS)
* **Web Server & App:** WordPress Container (Port 80)
* **Database:** MySQL 8.0 Container (Port 3306)
* **Network Access:** NAT Port Forwarding (Host Port `8080` → VM Port `80`)

---

## 2. Infrastructure Setup & Deployment

### 2.1 Network Configuration (VirtualBox NAT)

To access the WordPress site from the host machine browser, configure NAT Port Forwarding rules in VirtualBox.

| Rule | Host Port | Guest Port | Purpose                                   |
| ---- | --------: | ---------: | ----------------------------------------- |
| HTTP |    `8080` |       `80` | Access WordPress through the host browser |
| SSH  |    `2222` |       `22` | Remote SSH access to the Ubuntu Server    |

### 2.2 Container Deployment

To start the WordPress and MySQL containers in the background, navigate to the project directory and run Docker Compose:

```bash
cd ~/wordpress-stack
sudo docker compose up -d
```

To check if the containers are running:

```bash
sudo docker ps
```

---

## 3. Security Configuration (UFW Firewall)

The server is protected using the **Uncomplicated Firewall (UFW)** with a **Default Deny** policy to block unauthorized incoming network access.

### 3.1 Applied Firewall Rules

Set the default policy to deny incoming connections:

```bash
sudo ufw default deny incoming
```

Allow SSH connections:

```bash
sudo ufw allow 22/tcp
```

Allow HTTP connections:

```bash
sudo ufw allow 80/tcp
```

Enable the firewall:

```bash
sudo ufw enable
```

### 3.2 Verification

To verify the active firewall rules:

```bash
sudo ufw status verbose
```

**Expected Result:** The firewall status should be **active**, with ports `22/tcp` and `80/tcp` allowed.

---

## 4. Disaster Recovery & Automation

An automated Bash shell script performs daily database backups using `mysqldump` to help ensure data survival in case of database failure or data loss.

### 4.1 Backup Script (`backup.sh`)

```bash
#!/bin/bash

BACKUP_DIR="$HOME/wordpress-stack/backups"

mkdir -p "$BACKUP_DIR"

sudo docker exec mysql_db mysqldump \
  --no-tablespaces \
  -u wordpress_user \
  -pwordpress_db_pass \
  wordpress > "$BACKUP_DIR/wp_backup_$(date +%Y%m%d_%H%M%S).sql"

echo "Backup executed on $(date)" >> "$BACKUP_DIR/backup.log"
```

### 4.2 Automated Schedule (Cron Job)

The backup script is scheduled in the user's crontab to run automatically every day at **2:00 AM**:

```cron
0 2 * * * /bin/bash /home/ccmfinal/wordpress-stack/backup.sh
```

---

## 5. Maintenance Commands

The following commands can be used to monitor and maintain the WordPress application stack.

### Check Container Status

```bash
sudo docker compose ps
```

### View Application Logs

```bash
sudo docker compose logs -f
```

### Restart Application Stack

```bash
sudo docker compose restart
```

### Check Saved Backups

```bash
ls -l ~/wordpress-stack/backups/
```

---

## 6. Academic Integrity and AI Disclosure

In compliance with the Academic Integrity Policy, **"Be the pilot of AI, not the passenger,"** Gemini (Google AI) was used as a learning assistant during this project.

### Scope of Assistance

AI was used for:

* Syntax verification for Docker Compose, UFW rules, and Cron timing
* Troubleshooting the MySQL backup flag `--no-tablespaces`
* Document formatting

### Student Authorship & Execution

All hands-on technical work—including virtual machine configuration, port mapping, Docker container execution, firewall hardening, and backup testing—was performed, tested, and validated by the project team:

* Leah A. Nabor
* Maricar J. Valdez
* Paula Mae S. Mata
* Katrina Mae G. Rimando

---

## 7. Technical References and Citations

### Docker Documentation

**Docker Inc.** Docker Compose Overview and Data Volumes.
[Docker Compose Documentation](https://docs.docker.com/compose/?utm_source=chatgpt.com)

### Ubuntu UFW Documentation

**Canonical Ltd.** Uncomplicated Firewall (UFW) Official Guide.
[Ubuntu UFW Official Guide](https://help.ubuntu.com/community/UFW?utm_source=chatgpt.com)

### MySQL Documentation

**Oracle Corporation.** MySQL 8.0 Reference Manual: `mysqldump` Utility.
[MySQL 8.0 Reference Manual – mysqldump](https://dev.mysql.com/doc/refman/8.0/en/mysqldump.html?utm_source=chatgpt.com)

### The Open Group Documentation

**The Open Group.** `crontab` – Schedule Periodic Background Jobs.
[The Open Group – crontab](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/crontab.html?utm_source=chatgpt.com)
