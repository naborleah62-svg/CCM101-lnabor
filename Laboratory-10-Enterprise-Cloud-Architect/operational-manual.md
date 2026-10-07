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

* **Host Computer:** Windows OS running Oracle VirtualBox
* **Server OS:** Headless Ubuntu Server LTS (24.04 LTS)
* **Web Server & App:** WordPress Container (Port 80)
* **Database:** MySQL 8.0 Container (Port 3306)
* **Network Access:** NAT Port Forwarding (Host Port 8080 -> VM Port 80)

---

## 2. Infrastructure Setup & Deployment

### Network Configuration (VirtualBox NAT)
To access the WordPress site from the host machine browser, configure NAT Port Forwarding rules in VirtualBox:
* **HTTP Rule:** Host Port `8080` -> Guest Port `80`
* **SSH Rule:** Host Port `2222` -> Guest Port `22`

### Container Deployment
To start the WordPress and MySQL containers in the background:
```bash
cd ~/wordpress-stack
sudo docker compose up -d
To check if containers are running:

Bash
sudo docker ps
 3. Security Configuration (UFW Firewall)
The server is protected using the Uncomplicated Firewall (UFW) with a Default Deny policy to block unauthorized network access.

Applied Firewall Rules:
Bash
sudo ufw default deny incoming
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw enable
Verification:
To verify active firewall rules:

Bash
sudo ufw status verbose
Expected Result: Firewall status is active, and only ports 22/tcp (SSH) and 80/tcp (HTTP) are allowed.

4. Disaster Recovery & Automation
An automated Bash shell script performs daily database backups using mysqldump to ensure data survival.

Backup Script (backup.sh):
Bash
#!/bin/bash
BACKUP_DIR="$HOME/wordpress-stack/backups"
mkdir -p $BACKUP_DIR
sudo docker exec mysql_db mysqldump --no-tablespaces -u wordpress_user -pwordpress_db_pass wordpress > $BACKUP_DIR/wp_backup_$(date +%Y%m%d_%H%M%S).sql
echo "Backup executed on $(date)" >> $BACKUP_DIR/backup.log
Automated Schedule (Cron Job):
The script is scheduled in the user crontab to run automatically every day at 2:00 AM:

Plaintext
0 2 * * * /bin/bash /home/ccmfinal/wordpress-stack/backup.sh
5. Maintenance Commands
Check Container Status: sudo docker compose ps

View Application Logs: sudo docker compose logs -f

Restart Application Stack: sudo docker compose restart

Check Saved Backups: ls -l ~/wordpress-stack/backups/

6. Academic Integrity and AI Disclosure
In compliance with the Academic Integrity Policy ("Be the pilot of AI, not the passenger"), Gemini (Google AI) was used as a learning assistant during this project.

Scope of Assistance: AI was used for syntax verification (Docker Compose, UFW rules, Cron timing), troubleshooting MySQL backup flags (--no-tablespaces), and document formatting.

Student Authorship & Execution: All hands-on technical work—including virtual machine configuration, port mapping, Docker container execution, firewall hardening, and backup testing—was performed, tested, and validated by the project team (Leah A. Nabor, Maricar J. Valdez, Paula Mae S. Mata, and Katrina Mae G. Rimando).

7. Technical References and Citations
Docker Inc. Docker Compose Overview and Data Volumes.
URL: https://docs.docker.com/compose/

Canonical Ltd. Uncomplicated Firewall (UFW) Official Guide.
URL: https://help.ubuntu.com/community/UFW

Oracle Corporation. MySQL 8.0 Reference Manual: mysqldump Utility.
URL: https://dev.mysql.com/doc/refman/8.0/en/mysqldump.html

The Open Group. crontab - schedule periodic background jobs.
URL: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/crontab.html
