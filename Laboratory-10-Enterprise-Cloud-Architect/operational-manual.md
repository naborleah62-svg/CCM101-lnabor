# UNIVERSITY OF EASTERN PANGASINAN
**College of Information Technology**

**CCM101 – CLOUD COMPUTING**

# ENTERPRISE CLOUD ARCHITECT – OPERATIONAL MANUAL

**Project:** Secure Multi-Tier Web Application (WordPress + MySQL)

**Prepared by:**
- Paula Mae S. Mata
- Leah A. Nabor
- Katrina Mae G. Rimando
- Maricar J. Valdez

**Section:** BSIT 4G  
**Instructor:** Jenkielyn C. Torres  
**Date:** October 2026

---

# 1. INTRODUCTION

## 1.1 Purpose of the Manual

This operational manual presents the procedures for configuring, testing, securing, and maintaining the Secure Multi-Tier Web Application developed using WordPress and MySQL. It follows the actual demonstration sequence, beginning with configuration verification and continuing through application testing, security, database backup, automation, and maintenance.

Ubuntu Server, Docker, Docker Compose, WordPress, and MySQL have already been installed. Therefore, this manual focuses on the operation and verification of the existing environment rather than repeating the installation process.

## 1.2 Project Overview

The project demonstrates a containerized web application running on Ubuntu Server through Oracle VirtualBox. WordPress serves as the website and content management system, while MySQL stores website content and related data.

Docker Compose manages the services, network configuration, environment variables, and persistent database storage. The Windows host accesses the website through a configured network connection.

## 1.3 Objectives

The project aims to:

1. Verify the existing Ubuntu Server, Docker, and Docker Compose environment.
2. Inspect the WordPress and MySQL configuration.
3. Test website accessibility, database operation, and data persistence.
4. Review firewall rules and basic security practices.
5. Perform database backup and configure scheduled automation.
6. Demonstrate maintenance and troubleshooting procedures.

## 1.4 System Components

| Component | Description |
|---|---|
| Windows Host | Computer used to manage the virtual machine and access the website. |
| Oracle VirtualBox | Provides the virtual machine environment. |
| Ubuntu Server 24.04 LTS | Hosts Docker and the application services. |
| Docker Engine | Runs the application containers. |
| Docker Compose | Manages the WordPress and MySQL services. |
| WordPress | Provides the website and content management interface. |
| MySQL 8.0 | Stores the WordPress database. |
| UFW | Manages Ubuntu host firewall rules. |
| Bash and Cron | Support backup automation and routine operations. |

## 1.5 System Architecture

The application follows this architecture:

Windows Host → Oracle VirtualBox → Ubuntu Server → Docker Compose → WordPress and MySQL

The Windows browser accesses WordPress through the configured port. WordPress communicates with MySQL over the internal Docker network. The MySQL database uses persistent storage to retain data across container restarts.

---

# 2. ENVIRONMENT VERIFICATION

## 2.1 Start the Existing Virtual Machine

1. Open Oracle VirtualBox on the Windows host.
2. Start the existing Ubuntu Server virtual machine.
3. Log in using the configured Ubuntu account.
4. Wait for the terminal to become available.

No new virtual machine or operating system installation is required for this demonstration.

## 2.2 Verify Ubuntu Server

Run:

```bash
lsb_release -a
```

To display the assigned network addresses, run:

```bash
hostname -I
```

These commands show the Ubuntu release information and network addresses.

## 2.3 Verify Docker and Docker Compose

Run:

```bash
docker --version
docker compose version
sudo systemctl status docker
```

The team previously recorded Docker version `29.1.3` and Docker Compose version `2.40.3`. The versions displayed during the actual presentation should be used as the final evidence.

If the Docker service is stopped and needs to be started, run:

```bash
sudo systemctl start docker
```

## 2.4 Confirm the Project Directory

The primary Compose file used during the configuration check is located in `/home/ccmfinal`.

Run:

```bash
cd /home/ccmfinal
pwd
ls -la
```

Confirm that `docker-compose.yml` is present before executing Compose commands.

**Important:** A second Compose project was also identified in `/home/ccmfinal/wordpress-stack`. The team must confirm which project is intended for the presentation. Do not delete containers or volumes while identifying the active project.

---

# 3. APPLICATION CONFIGURATION

## 3.1 Validate the Docker Compose Configuration

From `/home/ccmfinal`, run:

```bash
docker compose config
```

This command displays the resolved configuration and helps identify configuration or syntax errors.

Review the following:

- WordPress and MySQL service definitions.
- Database name and credential variable names.
- WordPress database connection settings.
- Docker network configuration.
- Published application port.
- Persistent database volume.

The configuration previously displayed these service names:

- `wordpress`
- `db`

It also displayed the Docker network `ccmfinal_default` and the persistent database volume `ccmfinal_mysql_data`.

Passwords and other secrets must not be included in screenshots or public documentation.

## 3.2 Verify the Running Containers

Run:

```bash
docker compose ps
docker ps
```

The first command displays containers associated with the Compose project loaded from the current directory. The second lists all running containers on the Docker host.

The latest configuration check showed container names `wordpress` and `mysql` for the primary project. Earlier, a separate project was found with containers named `wordpress_app` and `mysql_db`.

Use the actual container and service names shown during the demonstration.

## 3.3 Verify the Application Port

Run:

```bash
docker port wordpress
```

For the primary Compose configuration, the expected mapping is:

**Ubuntu host port 8080 → WordPress container port 80**

The VirtualBox NAT forwarding rule must forward Windows host port `8080` to Ubuntu guest port `8080`.

If the browser cannot reach the website, check the actual Docker port mapping and VirtualBox forwarding configuration.

## 3.4 Verify Persistent Storage

Run:

```bash
docker volume ls
docker volume inspect ccmfinal_mysql_data
```

The Compose configuration uses a named volume for the MySQL data directory `/var/lib/mysql`.

Persistent storage helps preserve database data when the container is restarted. The team should not remove the volume during routine testing.

---

# 4. APPLICATION TESTING

## 4.1 Access WordPress

On the Windows host:

1. Open a web browser.
2. Visit `http://localhost:8080`, provided the VirtualBox port forwarding rule is configured correctly.
3. Confirm that the WordPress website, setup page, or login page appears.
4. If initial setup is complete, sign in using the authorized project account.

If the page does not load, check the container status, port mapping, VirtualBox networking, and firewall configuration.

## 4.2 Check Application Logs

Run the following commands from the primary project directory:

```bash
docker compose logs --tail 50
```

To inspect the WordPress logs:

```bash
docker logs wordpress --tail 50
```

To inspect the MySQL logs:

```bash
docker logs mysql --tail 30
```

Look for database connection errors, authentication failures, repeated restarts, or other service problems. If the container names differ, identify the correct containers with `docker compose ps` and use their actual names.

## 4.3 Verify WordPress and MySQL Operation

WordPress uses MySQL to store website content, settings, and other data. The primary Compose configuration specifies `db:3306` as the database host.

To test the application:

1. Open the WordPress dashboard.
2. Create a temporary test page or post.
3. Save or publish the content.
4. Open the page in the browser.
5. Confirm that the saved content can be retrieved.

Successful saving and retrieval of content provide practical evidence that the application is operating. If an error occurs, review the logs and verify the database settings.

## 4.4 Test Data Persistence

After saving the test content, run:

```bash
docker compose restart
docker compose ps
```

Wait for the services to become available. Reopen WordPress and verify that the saved content is still present.

This test checks persistence across a container restart. It does not prove that a database backup can be restored.

## 4.5 Testing Results

| Test | Expected Result | Actual Result |
|---|---|---|
| Docker verification | Version information is displayed. | Record during demonstration. |
| Compose validation | Configuration displays without errors. | Record during demonstration. |
| Container status | WordPress and MySQL are running. | Record during demonstration. |
| Website access | WordPress loads from the Windows host. | Record during demonstration. |
| Database operation | Test content can be saved and retrieved. | Record during demonstration. |
| Persistence | Content remains after restart. | Record during demonstration. |

Only mark a test successful after verifying the actual result.

---

# 5. SECURITY CONFIGURATION

## 5.1 Review UFW Firewall Status

Run:

```bash
sudo ufw status verbose
```

Review whether UFW is active and inspect the existing rules before making changes.

## 5.2 Configure Firewall Rules

The following commands are examples for an environment that requires SSH administration and WordPress access through Ubuntu port `8080`.

Allow SSH if required:

```bash
sudo ufw allow 22/tcp
```

Allow the web application port:

```bash
sudo ufw allow 8080/tcp
```

Set the default policies:

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
```

Verify the rules:

```bash
sudo ufw status numbered
```

If UFW is inactive and the rules have been reviewed, enable it:

```bash
sudo ufw enable
```

Before changing firewall settings, confirm that the SSH rule is appropriate for the environment to avoid losing remote access. Do not expose SSH unnecessarily.

Docker-published ports may interact with UFW differently from ordinary host services. Verify access from the actual host and network rather than assuming that UFW blocks all published container ports.

## 5.3 Protect MySQL and Credentials

The primary Compose configuration does not publish a MySQL host port. WordPress accesses the database through the internal Docker network, so MySQL does not need to be directly exposed for normal operation.

Security practices include:

- Keep database passwords private.
- Do not upload secret environment files to a public repository.
- Avoid publishing MySQL port `3306` unless required.
- Restrict access to the database.
- Keep persistent storage and backups protected.
- Apply appropriate updates to the operating system and application images.

The database passwords appeared in the terminal output used during preparation. Replace exposed credentials before public submission or production use, and remove them from screenshots and public documentation.

---

# 6. DATABASE BACKUP AND AUTOMATION

## 6.1 Create the Backup Directory

From the primary project directory, run:

```bash
cd /home/ccmfinal
mkdir -p backups
ls -ld backups
```

## 6.2 Create the Backup Script

Create the script:

```bash
nano /home/ccmfinal/backup.sh
```

Use the following example:

```bash
#!/bin/bash
set -euo pipefail

PROJECT_DIR="/home/ccmfinal"
BACKUP_DIR="$PROJECT_DIR/backups"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
BACKUP_FILE="$BACKUP_DIR/wordpress_${TIMESTAMP}.sql"
TEMP_FILE="${BACKUP_FILE}.tmp"

cd "$PROJECT_DIR"
mkdir -p "$BACKUP_DIR"

if docker compose exec -T db sh -c \
  'exec mysqldump --no-tablespaces -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE"' \
  > "$TEMP_FILE"; then
    if [ -s "$TEMP_FILE" ]; then
        mv "$TEMP_FILE" "$BACKUP_FILE"
        echo "Database backup completed: $BACKUP_FILE"
    else
        rm -f "$TEMP_FILE"
        echo "ERROR: The backup file is empty."
        exit 1
    fi
else
    rm -f "$TEMP_FILE"
    echo "ERROR: Database backup command failed."
    exit 1
fi
```

Save the file and exit the editor.

This script assumes that the MySQL service has the environment variables `MYSQL_USER`, `MYSQL_PASSWORD`, and `MYSQL_DATABASE`, as shown in the resolved Compose configuration. Verify the actual configuration before running the script.

## 6.3 Make the Script Executable

Run:

```bash
chmod +x /home/ccmfinal/backup.sh
```

Execute the script:

```bash
/home/ccmfinal/backup.sh
```

Check the generated files:

```bash
ls -lh /home/ccmfinal/backups
```

A successful backup should produce a non-empty SQL file. If the script fails, review the terminal output and MySQL logs before reporting success.

For a basic content check, run:

```bash
head -n 20 /home/ccmfinal/backups/wordpress_*.sql
```

Backup files may contain sensitive website data. Keep them in a protected location and do not commit them to a public repository.

## 6.4 Schedule the Backup Using Cron

Open the current user's crontab:

```bash
crontab -e
```

Add this entry to schedule the backup daily at 2:00 AM:

```cron
0 2 * * * /bin/bash /home/ccmfinal/backup.sh >> /home/ccmfinal/backups/cron.log 2>&1
```

Save the entry and verify the schedule:

```bash
crontab -l
```

The entry schedules the backup but does not prove that the task has run successfully. Verify the generated SQL file and review the Cron log after execution.

## 6.5 Recovery Considerations

A database dump protects database content but does not automatically include all WordPress media files or application configuration files.

For a more complete recovery plan:

1. Protect and retain database backup files.
2. Back up the WordPress uploads directory and relevant configuration files separately.
3. Document the restoration procedure.
4. Test restoring a backup in a safe environment.
5. Verify that the restored website and database work correctly.

Do not overwrite the active database during the classroom demonstration unless the team has an approved recovery plan.

---

# 7. MAINTENANCE AND TROUBLESHOOTING

## 7.1 Routine Maintenance Commands

Run Compose commands from the directory containing the correct Compose file.

| Task | Command |
|---|---|
| Check Compose services | `docker compose ps` |
| List running containers | `docker ps` |
| View service logs | `docker compose logs --tail 50` |
| Restart services | `docker compose restart` |
| Stop services | `docker compose stop` |
| Start stopped services | `docker compose start` |
| Inspect volumes | `docker volume ls` |
| Check firewall | `sudo ufw status verbose` |

## 7.2 Common Problems and Solutions

### WordPress Does Not Load

- Confirm that the WordPress container is running.
- Verify Docker port mapping and VirtualBox NAT forwarding.
- Check the firewall rules.
- Review the WordPress logs.

### WordPress Cannot Connect to MySQL

- Confirm that the MySQL container is running.
- Verify the database name, username, password, and service hostname.
- Confirm that WordPress uses `db:3306` when using the primary Compose configuration.
- Review WordPress and MySQL logs.

### Docker Compose Cannot Find the Configuration File

Run:

```bash
pwd
ls -la
```

Change to the directory containing `docker-compose.yml` or `compose.yaml` before running Compose commands.

### The Backup Script Fails

- Confirm that the MySQL service is running.
- Verify the environment variable names.
- Confirm that the backup directory is writable.
- Review the command output and Cron log.
- Check that a non-empty SQL file was generated.

### Data Appears Missing After Restart

- Confirm that the correct Compose project and persistent volume are being used.
- Inspect the volume configuration and service logs.
- Do not remove volumes or recreate the application before identifying the cause.

**Warning:** Do not use `docker compose down -v` during routine maintenance because it can remove associated named volumes and cause data loss.

---

# 8. FINAL DEMONSTRATION CHECKLIST

Complete this checklist during the actual presentation.

- [ ] Ubuntu Server is running.
- [ ] Docker and Docker Compose versions are verified.
- [ ] The correct project directory is identified.
- [ ] The Compose configuration is displayed and validated.
- [ ] WordPress and MySQL are running.
- [ ] WordPress is accessible from the Windows host.
- [ ] Test content can be saved and retrieved.
- [ ] Content remains after a container restart.
- [ ] UFW status and rules are reviewed.
- [ ] MySQL is not unnecessarily exposed to external networks.
- [ ] The backup script executes successfully.
- [ ] A non-empty SQL backup file is verified.
- [ ] The Cron schedule is displayed.
- [ ] Maintenance commands are demonstrated.
- [ ] Screenshots and source files are documented in the repository.

Record the actual results during the presentation. Mark each item complete only after it has been verified.

---

# 9. PROJECT REPOSITORY

The repository should contain the files required to document the project and its operational procedures.

Recommended structure:

```text
Laboratory-10-Enterprise-Cloud-Architect/
├── README.md
├── architecture-diagram.png
├── docker-compose.yml
├── backup.sh
├── operational-manual.md
└── final-reflection.md
```

The README should summarize the project, technology stack, access URL, and operational commands.

The architecture diagram should show the Windows host, Oracle VirtualBox, Ubuntu Server, Docker, WordPress, MySQL, network flow, and persistent database volume.

Do not upload database dumps, secret environment files, actual passwords, or other confidential information to a public repository.

---

# 10. ACADEMIC INTEGRITY AND AI DISCLOSURE

The team should accurately disclose any AI tools used for research, writing, configuration review, or troubleshooting according to the instructor's requirements.

All commands and technical explanations must be checked against the actual implementation. Screenshots, terminal outputs, and test results should come from the team's own environment and demonstration.

The team remains responsible for understanding, validating, and presenting the submitted work.

---

# 11. FINAL REFLECTION

This project demonstrates how a multi-tier web application can be operated using virtualization, Linux, Docker, and Docker Compose. WordPress provides the website interface, while MySQL stores its content and related data. Network configuration allows the website to be accessed from the host computer, and firewall rules and database access restrictions contribute to the security of the environment.

The testing procedures help verify application availability, database operation, and data persistence. The database backup script and Cron schedule provide a foundation for routine data protection and automation. Maintenance commands and troubleshooting procedures help identify common operational problems.

Through this activity, the team gained practical experience in inspecting configuration files, operating containers, reviewing logs, applying basic security controls, creating backups, and documenting maintenance procedures. These skills are important for operating reliable and maintainable cloud-based services.

**End of Operational Manual**
