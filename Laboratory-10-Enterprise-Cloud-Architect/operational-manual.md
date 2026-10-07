# CCM101 - Cloud Computing
## Enterprise Cloud Architect – Operational Manual

**Project:** Secure Multi-Tier Web Application  
**Application Stack:** WordPress + MySQL  
**Prepared by:** Paula Mae S. Mata | Leah A. Nabor | Katrina May G. Rimando |  Maricar J. Valdez
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
To open the WordPress site on the host browser, configure NAT Port Forwarding:
* **HTTP Rule:** Host Port `8080` -> Guest Port `80`
* **SSH Rule:** Host Port `2222` -> Guest Port `22`

### Container Deployment
To start the WordPress and MySQL containers in the background:
```bash
cd ~/wordpress-stack
sudo docker compose up -d
