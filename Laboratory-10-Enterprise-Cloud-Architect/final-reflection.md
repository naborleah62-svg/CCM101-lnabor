# Final Reflection: Mission 10 - The Enterprise Cloud Architect

**Course:** CCM101 - Cloud Infrastructure Services  
**Student Name:** Leah Arao Nabor  
**Repository:** CCM101-Inabor  

---

## 1. Project Overview
In Mission 10, I built a complete cloud server environment using an Ubuntu Server Virtual Machine in VirtualBox. I deployed a WordPress website and a MySQL database using Docker Compose. I also secured the server with UFW firewall and created an automatic daily backup script using Bash and Cron.

---

## 2. Key Learnings

### Virtualization and Networking
I learned how to set up an Ubuntu Virtual Machine and configure NAT port forwarding in VirtualBox. Mapping port 8080 to port 80 allowed me to access my WordPress website from my host computer browser.

### Containerization with Docker
Using Docker Compose made it easy to run WordPress and MySQL in separate containers. Using Docker volumes saved my website data so it is not deleted when containers restart.

### Server Security (UFW)
I learned how to protect my server using Uncomplicated Firewall (UFW). By blocking all incoming connections by default and only allowing ports 22 (SSH) and 80 (HTTP), my server stays safe from unauthorized access.

### Automation and Backups
I wrote a shell script (`backup.sh`) that automatically backs up the database. Scheduling this script with `crontab` to run every day at 2:00 AM keeps my data safe if errors happen.

---

## 3. Academic Integrity and AI Disclosure

Following the Academic Integrity Policy (*"Be the pilot of AI, not the passenger"*), I used **Gemini (Google AI)** as a learning assistant.

* **How AI was used:** AI helped me understand Linux commands, fix script errors (such as MySQL `--no-tablespaces`), and format markdown documents properly.
* **My Own Work:** All actual hands-on tasks—setting up the VM, running Docker containers, setting firewall rules, testing backup scripts, and organizing files on GitHub—were done and verified by me.

---

## 4. References and Citations

1. **Docker Inc.** *Docker Compose Overview and Data Volumes*.  
   URL: https://docs.docker.com/compose/
2. **Canonical Ltd.** *Uncomplicated Firewall (UFW) Official Security Guide*.  
   URL: https://help.ubuntu.com/community/UFW
3. **Oracle Corporation.** *MySQL 8.0 Reference Manual: mysqldump Utility*.  
   URL: https://dev.mysql.com/doc/refman/8.0/en/mysqldump.html
4. **The Open Group.** *crontab - schedule periodic background jobs*.  
   URL: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/crontab.html
