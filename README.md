*This project has been created as part of the 42 curriculum by jiyawawng.*

## Description

Inception is a system administration project from the 42 curriculum. The goal is to set up a small infrastructure composed of different services running inside Docker containers, orchestrated with Docker Compose, all inside a virtual machine.

### Services included

| Service | Role |
| :--- | :--- |
| **NGINX** | Reverse proxy, only entrypoint via HTTPS (port 443) |
| **WordPress** | CMS with php-fpm, no web server |
| **MariaDB** | Database for WordPress |

## Project Structure

```
.
├── DEV_DC.md
├── Makefile
├── README.md
├── USER_DC.md
├── secrets
│   ├── credentials.txt
│   ├── db_password.txt
│   └── db_root_password.txt
└── srcs
    ├── docker-compose.yml
    └── requirements
        ├── bonus
        │   ├── adminer
        │   │   ├── Dockerfile
        │   │   └── conf
        │   │       └── www.conf
        │   ├── portainer
        │   │   └── Dockerfile
        │   ├── portfolio
        │   │   ├── Dockerfile
        │   │   └── html
        │   │       └── index.html
        │   ├── redis
        │   │   ├── Dockerfile
        │   │   └── conf
        │   │       └── redis.conf
        │   └── vsftpd
        │       ├── Dockerfile
        │       ├── conf
        │       │   └── vsftpd.conf
        │       └── tools
        │           └── ftp-setup.sh
        ├── mariadb
        │   ├── Dockerfile
        │   ├── conf
        │   │   └── 50-server.cnf
        │   └── tools
        │       └── db-setup.sh
        ├── nginx
        │   ├── Dockerfile
        │   └── conf
        │       └── nginx.conf
        └── wordpress
            ├── Dockerfile
            ├── conf
            │   └── www.conf
            └── tools
                └── wp-setup.sh
```

### Design Choices

#### ◦  Virtual Machines vs Docker

| | Virtual Machine | Docker Container |
| :--- | :--- | :--- |
| Includes | Full OS + kernel | Only the app + dependencies |
| Size | Several GB | Tens of MB |
| Startup | Minutes | Seconds |
| Isolation | Complete (hardware level) | Process level |
| Use case | Full system simulation | Running a single service |

This project runs Docker inside a Virtual Machine (VirtualBox + Debian) as required by the subject.

####  ◦ Secrets vs Environment Variables

| | Environment Variables | Docker Secrets |
| :--- | :--- | :--- |
| Stored in | `.env` file / shell | `/run/secrets/` inside container |
| Visible in | `docker inspect` | Only to the specific container |
| Safe for passwords | ❌ No | ✅ Yes |
| Use case | Non-sensitive config | Passwords, API keys |

In this project:
- `.env` stores non-sensitive variables (domain name, database name, usernames)
- Docker secrets store all passwords (database password, root password, WordPress admin password)

####  ◦ Docker Network vs Host Network

| | Docker Network | Host Network |
| :--- | :--- | :--- |
| Isolation | ✅ Containers isolated | ❌ Shares host network |
| Container communication | By container name (DNS) | By localhost |
| Security | ✅ More secure | ❌ Less secure |
| Subject requirement | ✅ Required | ❌ Forbidden |

This project uses a custom bridge network called `inception`. All containers communicate through container names (e.g., `wordpress:9000`, `mariadb:3306`).

####  ◦ Docker Volumes vs Bind Mounts

| | Docker Volumes | Bind Mounts |
| :--- | :--- | :--- |
| Path control | Docker manages it | You specify the path |
| Portability | ✅ Works anywhere | ❌ Path must exist on host |
| Subject requirement | ✅ Required | ❌ Forbidden |
| Data location | `/var/lib/docker/volumes/` | Any host path |

This project uses named volumes

## Resources
https://docs.docker.com/get-started/docker-overview/

https://docs.docker.com/compose/

https://nginx.org/en/docs/index.html

https://wordpress.com/blog/2022/11/14/setting-up-your-local-development-environment-for-wordpress/

## Features

- HTTPS only via NGINX (TLSv1.2 / TLSv1.3)
- Automatic WordPress installation on first startup
- Dynamic WordPress salts generated on each fresh install
- Persistent data stored in `/home/jiyawang/data/`
- All passwords managed via Docker secrets

---

## Technical Choices

| Choice | Reason |
| :--- | :--- |
| `debian:bullseye` / `debian:bookworm` | Stable, well documented, required by subject |
| php-fpm instead of Apache | Lighter, works well with NGINX as reverse proxy |
| WP-CLI for WordPress setup | Allows automated installation without browser |
| Docker secrets for passwords | More secure than environment variables |
| Named volumes with driver_opts | Satisfies both subject requirements: named volume + `/home/jiyawang/data/` path |
| Bridge network | Containers communicate by name, isolated from host |

---

## AI Usage

AI was used as a learning and debugging assistant throughout this project. Below is a honest description of how it was used:

### Concept Learning and Debugging
- Asked AI to explain like:
    - what Docker is and how it differs from a Virtual Machine
    - PID 1 and why `tail -f /dev/null` is a bad practice in containers
    - the difference between bind mounts and named volumes
    - Docker secrets vs environment variables
    - to review my configuration files for all of the subject requirements

### What I did myself
- All final implementation decisions
- Writing and testing all Dockerfiles and entrypoint scripts
- Setting up the VirtualBox VM and network configuration
- Debugging container connectivity issues
- All Git commits and project structure
