# Operational Manual: Enterprise Cloud Infrastructure Deployment

## 1. System Architecture Overview
This infrastructure hosts a containerized WordPress platform running on an Ubuntu Server Virtual Machine managed via VirtualBox.

* **Host Environment:** Windows OS / VirtualBox
* **Server OS:** Ubuntu Server LTS
* **SSH Management Port:** Port 22 (Mapped to Host 2222)
* **Web Service Port:** Port 80 (Mapped to Host 8080)
* **Container Stack:** Docker Compose (WordPress + MySQL 8.0)

---

## 2. Infrastructure Setup & Deployment

### Step 1: Network Configuration
Host NAT Port Forwarding rules configured on VirtualBox:
* **SSH:** `127.0.0.1:2222` -> Guest `22`
* **HTTP:** `127.0.0.1:8080` -> Guest `80`

### Step 2: Deployment via Docker Compose
To deploy the full web and database stack:
```bash
cd ~/wordpress-stack
sudo docker compose up -d
