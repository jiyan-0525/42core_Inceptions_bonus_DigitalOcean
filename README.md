*This project has been created as part of the 42 curriculum by jiyawang*

### 🚀 Working Services (Final Setup)

Once the containers are running, you can access the services:

| Service | URL / Access |
| :--- | :--- |
| **WordPress** | [https://127.0.0.1](https://127.0.0.1) 
|               | [https://jiyan.42.fr](https://jiyan.42.fr)
| **Portfolio (CV)** | [https://127.0.0.1/portfolio](https://127.0.0.1/portfolio) |
| **Adminer** | [https://127.0.0.1/adminer](https://127.0.0.1/adminer) |
| **Portainer** | [https://localhost:9443](https://localhost:9443) ```run frist:  docker restart portainer ```|
| **FTP Server**  | `Port 21` (User: `jiyan`, Pass: `ftp_password`), `ftp jiyawang.42.fr`  | 
| **Redis Cache**                          | Integrated into WordPress |

**Via SSH (for container management):**
```bash
ssh root@127.0.0.1 -p 4243
```

## Description

Inception is a Docker project that demonstrates the fundamentals of containerization and orchestration. The goal of this project is to create a small infrastructure using Docker Compose, with multiple services (nginx, mariadb) running in isolated containers. This project teaches the principles of containerization, multi-container applications, and infrastructure as code.

The project includes:
- **nginx**: A web server container serving as a reverse proxy
- **mariadb**: A relational database container for data persistence
- **docker-compose.yml**: Orchestration configuration for managing multiple containers

## Project Structure

```
├── Makefile
├── README.md
├── VM_setup.txt
├── secrets
│   ├── credentials.txt
│   ├── db_password.txt
│   └── db_root_password.txt
├── srcs
│   ├── docker-compose.yml
│   └── requirements
│       ├── bonus
│       │   ├── adminer
│       │   │   ├── Dockerfile
│       │   │   └── conf
│       │   │       └── www.conf
│       │   ├── portainer
│       │   │   └── Dockerfile
│       │   ├── portfolio
│       │   │   ├── Dockerfile
│       │   │   └── html
│       │   │       └── index.html
│       │   ├── redis
│       │   │   ├── Dockerfile
│       │   │   └── conf
│       │   │       └── redis.conf
│       │   └── vsftpd
│       │       ├── Dockerfile
│       │       ├── conf
│       │       │   └── vsftpd.conf
│       │       └── tools
│       │           └── ftp-setup.sh
│       ├── mariadb
│       │   ├── Dockerfile
│       │   ├── conf
│       │   │   └── 50-server.cnf
│       │   └── tools
│       │       └── db-setup.sh
│       ├── nginx
│       │   ├── Dockerfile
│       │   └── conf
│       │       └── nginx.conf
│       └── wordpress
│           ├── Dockerfile
│           ├── conf
│           │   └── www.conf
│           ├── tools
│           │   └── wp-setup.sh
│           └── wp-config.php
└── steptosetup.txt
```

## Instructions

## Resources
https://docs.docker.com/get-started/docker-overview/

https://docs.docker.com/compose/

https://nginx.org/en/docs/index.html

https://dev.to/alejiri/docker-nginx-wordpress-mariadb-tutorial-inception42-1eok

## Project description

1. Virtual Machines vs. Docker


VMs: Each VM includes a full Guest OS, making them heavy, slow to boot, and resource-intensive.

Docker: Containers share the Host OS kernel. They are lightweight, start in seconds, and require significantly less CPU and RAM.

2. Secrets vs. Environment Variables

Environment Variables: Best for non-sensitive configuration (e.g., DEBUG=true). They are easily visible via docker inspect, making them unsafe for passwords.

Secrets: Encrypted at rest and only mounted into the container's memory during runtime. We use these for sensitive data like database passwords and API keys.

3. Docker Network vs. Host Network

Docker Network (Bridge): The default. It provides an isolated private network. Containers communicate via service names (DNS), and ports must be explicitly mapped to the host.

Host Network: The container shares the host's IP and port space directly. While faster, it lacks isolation and can lead to port conflicts.

4. Docker Volumes vs. Bind Mounts

Docker Volumes: Managed by Docker (stored in /var/lib/docker/volumes). This is the preferred way to persist data as it is more secure and independent of the host's file structure.

Bind Mounts: Maps a specific path on the Host OS directly to the container. Useful for development (e.g., syncing code changes), but relies on the host having a specific directory structure.

### Prerequisites
- Docker and Docker Compose installed on your system
- Make utility

### Compilation & Setup

To build and start the infrastructure, run:

```bash
make
```

This command will:
1. Build the Docker images for nginx and mariadb from their respective Dockerfiles
2. Start all services defined in docker-compose.yml
3. Initialize the database and web server containers

### Execution

To start the containers:

```bash
make up
```

To stop the containers:

```bash
make down
```

To view logs:

```bash
make logs
```

### Commands

```bash
docker compose up -d --build
```

```bash
docker ps
docker logs wordpress
```

```bash
docker exec -it mariadb mariadb -u root

docker exec -it mariadb mysql -u root -proot_password -e "SELECT user, host FROM mysql.user;"
```

#### 1. Stop and remove all containers, networks, and images associated with the project

```bash
docker-compose down --rmi all --volumes --remove-orphans
```
#### 2. Hard delete all volumes (Be careful if you have other projects)
```bash
docker volume rm $(docker volume ls -q)
```
#### 3. Build from scratch without using any cache
```bash
docker-compose up --build --force-recreate
```
