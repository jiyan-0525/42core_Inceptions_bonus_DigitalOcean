# Inception User Guide

## 📋 Services Overview

This stack provides the following services:

| Service | Description | URL |
| :--- | :--- | :--- |
| **WordPress** | Main website and blog platform | [https://jiyawang.42.fr](https://jiyawang.42.fr) |
| **adminer** | Database management | [https://jiyawang.42.fr/adminer](https://jiyawang.42.fr/adminer) |
| **portfolio** | Portfolio website | [https://jiyawang.42.fr/portfolio](https://jiyawang.42.fr/portfolio) |
| **portainer** | Docker container management | [https://jiyawang.42.fr:9443](https://jiyawang.42.fr:9443) |
| **ftp** | Port 21 / User: jiyan Pass: ftp_password | ftp jiyawang.42.fr |
| **NGINX** | Reverse proxy, handles all HTTPS traffic | internal |
| **MariaDB** | Database for WordPress | internal |
| **redis** | Cache for WordPress | internal |
---

## 1. 📦 Basic Commands

#### Build and start everything:
```bash
make
```

#### Stop the containers:
```bash
make down
```

#### Start the containers:
```bash
make up
```

#### Restart the containers:
```bash
make restart
```

#### Full reset:
```bash
make re
```

---

## 2. 🔑 Credentials

All credentials are stored as Docker secrets inside the VM:

| Secret | Location on VM |
| :--- | :--- |
| Database password | `/run/secrets/db_password` |
| Database root password | `/run/secrets/db_root_password` |
> ⚠️ Never commit secrets to Git. They are stored only on the VM.

To view a secret (inside the VM):
```bash
cat /run/secrets/db_password
```

---

## 3. 🐳 Docker Commands

#### Check running containers:
```bash
docker ps
```

#### Check logs:
```bash
docker logs wordpress
docker logs mariadb
docker logs nginx
```

#### Access inside containers:
```bash
docker exec -it nginx bash
docker exec -it wordpress bash
docker exec -it mariadb bash
```

#### Access database:
```bash
docker exec -it mariadb mariadb -u root -p
```

---

## 4. ✅ Check Services are Running

```bash
# All containers should show "Up"
docker ps

# Check NGINX is serving HTTPS
curl -k https://jiyawang.42.fr

# Check WordPress can reach the database
docker logs wordpress | tail -20

# Check MariaDB is healthy
docker exec -it mariadb mariadb -u root -p -e "SHOW DATABASES;"
```

---

## 5. ⚠️ Troubleshooting

#### If werserver can't open, use w3m or lynx
```bash
w3m https://jiyawang.42.fr
```
```bash
lynx https://jiyawang.42.fr
```

#### To login in

```bash
https://jiyawang.42.fr/wp-login.php
```
#### CLI commands

```bash
docker exec -it wordpress /bin/bash
```
```bash
wp comment create --comment_post_ID=1 --comment_author="Alex" --comment_content="This is a comment via CLI" --path=/var/www/html --allow-root
```
```bash
wp comment list --path=/var/www/html --allow-root
```
```bash
# --- New commands to add ---
wp plugin install woocommerce --activate --allow-root --path="$WP_PATH"
wp option update blogdescription "Welcome to my Inception site" --allow-root --path="$WP_PATH"
# ---------------------------
```

#### If WordPress shows database error:
```bash
docker restart mariadb
docker restart wordpress
```