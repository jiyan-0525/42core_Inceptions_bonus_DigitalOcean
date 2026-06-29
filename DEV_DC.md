# Inception Development Setup

## Prerequisites

- VirtualBox (Debian 13 x64 DgitalOcean)
- SSH access to the VM
- Docker & Docker Compose installed on the VM
- `make` installed

---

## 1. Connect to the VM

```bash
ssh jiyawang@46.101.164.165
```
 ⚠️ If Connection closed by 127.0.0.1 port 4243

  Change the port to #port 4243:

```bah
sudo nano /etc/ssh/sshd_config
```

---
## 2. Add user to Docker group (first time only)

```bash
usermod -aG sudo jiyawang
# Log out and back in for changes to take effect
```

---

## 3. Install Docker (first time only)

```bash
sudo apt install -y docker.io docker-compose
sudo systemctl start docker
sudo systemctl enable docker
docker --version
newgrp docker
sudo usermod -aG docker jiyawang
```

---

## 4. Configure Secrets

Create the secrets directory and files:

```bash
mkdir -p secrets
echo "your_db_password"    > secrets/db_password.txt
echo "your_root_password"  > secrets/db_root_password.txt
```
> ⚠️ Never commit the `secrets/` folder to Git.

---

## 5. Configure Environment Variables

```bash
nano .env
```
Required variables in `.env`:

```env
DOMAIN_NAME=jiyawang.42.fr
MYSQL_DATABASE=wordpress
MYSQL_USER=wpuser
WORDPRESS_DB_HOST=mariadb
```

---

## 6. Add domain to /etc/hosts (on host machine)

```bash
sudo nano /etc/hosts
# Add this line:
127.0.0.1   jiyawang.42.fr
```
---

## 7. Build and Launch

```bash
# Build images and start all containers
make

# Or directly with Docker Compose
docker compose up -d --build
```

---

## 8. Container & Volume Management

#### List all containers:
```bash
docker ps -a
```

#### Stop and remove containers:
```bash
make down
# or
docker compose down
```

#### Remove containers AND volumes (full reset):
```bash
make fclean
# or
docker compose down -v
```

#### Rebuild a single service:
```bash
docker compose up -d --build wordpress
```

---

## 9. 💾 Data Persistence

All persistent data is stored on the VM using bind mounts:

| Service | Data location on VM |
| :--- | :--- |
| WordPress files | `/home/jiyawang/data/wordpress` |
| MariaDB database | `/home/jiyawang/data/mariadb` |
| portainer | `/home/jiyawang/data/portainer` |

Data **survives** container restarts and rebuilds because it lives on the VM filesystem, not inside the container.

To manually inspect the data:
```bash
ls /home/jiyawang/data/wordpress
ls /home/jiyawang/data/mariadb
ls /home/jiyawang/data/portainer
```

To fully wipe data (clean reset):
```bash
make fclean
sudo rm -rf /home/jiyawang/data/wordpress/*
sudo rm -rf /home/jiyawang/data/mariadb/*
sudo rm -rf /home/jiyawang/data/portainer/*
```

---

## 🌐 Browser Proxy Setup (for accessing VM services)

Since the VM runs on NAT, you need an SSH tunnel + SOCKS proxy.

### Step 1 — Start the SSH tunnel

```bash
ssh -D 9090 -p 4243 jiyawang@localhost
```
Change the port to 4243:
```bah
sudo nano /etc/ssh/sshd_config
```

> Keep this terminal open.

### Step 2 — Configure Firefox SOCKS proxy

1. Open Firefox → **Settings** → search `proxy`
2. Click **Settings...** under Network Settings
3. Select **Manual proxy configuration**
4. Set:

| Field | Value |
| :--- | :--- |
| SOCKS Host | `127.0.0.1` |
| Port | `9090` |
| SOCKS version | `SOCKS v5` |

5. Check ✅ **Proxy DNS when using SOCKS v5**
6. Click **OK**

### Step 3 — Access the services

| Service | URL |
| :--- | :--- |
| **WordPress** | [https://jiyawang.42.fr](https://jiyawang.42.fr) |

### Reset Firefox proxy

When done, go back to Firefox proxy settings and select **No proxy**.
