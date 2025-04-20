# 🐳 Inception

A self-contained Docker infrastructure featuring a full web environment with WordPress, MariaDB, NGINX (TLS-enabled), Redis, FTP, Adminer, CAdvisor, and a simple Flask-based static site. Everything is built from custom Dockerfiles using Alpine Linux for a lightweight and performant setup.

---

## 📜 Project Constraints

- Each service has a dedicated container
- The containers must be built from the penultimate stable
version of Alpine 
- All services has a custom Dockerfile (no pre-built images used except Alpine base)
- TLS (NGINX) using only TLSv1.2 or TLSv1.3
- Built and orchestrated exclusively via `Makefile` + `docker-compose`
- Volumes for the database, wordpress files and the website files
- The volumes must be in `/home/$USER/data/`
- A docker-network that establishes the connection between your containers
- This domain name must be login.42.fr

---

## 📦 Services Overview

| Service        | Description                                                                 |
|----------------|-----------------------------------------------------------------------------|
| **NGINX**      | Acts as a secure reverse proxy (TLSv1.2/1.3).                      |
| **WordPress**  | PHP-based CMS running with `php-fpm`, no NGINX inside.                      |
| **MariaDB**    | Database service for WordPress.                                             |
| **Redis**      | Caching system to optimize WordPress performance.                           |
| **FTP Server** | FTP access to the WordPress for file transfor.                              |
| **Website**    | Simple Flask-based static website.                                          |
| **Adminer**    | Web UI to manage MariaDB.                                                   |
| **CAdvisor**   | Container resource usage and performance monitor.                           |


NGINX acts as a secure reverse proxy, handling all incoming HTTPS traffic with strong encryption (TLSv1.2 and TLSv1.3 only). It performs the following:

- Serves **WordPress** using FastCGI to forward PHP requests to the `php-fpm` backend.
- Proxies **Adminer** for database management.
- Serves the **Flask static website** via reverse proxy to the `website` container.
- Uses strong SSL ciphers and security headers to ensure encrypted communication.
- Mounts SSL cert/key securely using Docker secrets.

---

## 🛠️ Project Structure

```
Makefile                       # Build, run, clean commands
srcs/
│
├── docker-compose.yml         # All services declared here
├── requirements/
│   ├── nginx/                 # NGINX config + Dockerfile
│   ├── wordpress/             # WordPress setup + Dockerfile
│   ├── mariadb/               # MariaDB setup + Dockerfile
│   └── bonus/
│       ├── adminer/           # Adminer Dockerfile
│       ├── cadvisor/          # CAdvisor Dockerfile
│       ├── redis/             # Redis Dockerfile
│       ├── ftp/               # FTP server Dockerfile
│       └── website/           # Flask app Dockerfile
├── .env                       # Env variables 
└── secrets/                   # Passwords, salts, SSL certs (auto-generated)
```

---

## 🧪 Usage

### Prerequisites

- Docker & Docker Compose installed
- `make` utility

### Build & Run

```bash
make
```

This is equivalent to `make build && make up`.

To access the services via a browser:
- **WordPress**: [https://eel-brah.42.fr](https://eel-brah.42.fr)  
- **Sample Website**: [https://resume.eel-brah.42.fr](https://resume.eel-brah.42.fr)  
- **Adminer**: [https://eel-brah.42.fr/adminer](https://eel-brah.42.fr/adminer)  
- **CAdvisor**: [http://localhost:8080](http://localhost:8080)  


### Other Commands

```bash
make down           # Stop and remove containers
make clean          # Down + remove volumes
make fclean         # Clean + remove images and secrets
make re             # Full rebuild from scratch
make logs           # Follow logs for all containers
make logs-service service=wordpress # Logs for a specific service
make shell service=nginx           # Open shell in container
make update         # Update Alpine base images
```

---

## 🔐 Secrets Management

The script `generate_secrets.sh` auto-generates:

- Strong passwords for MariaDB, WordPress, FTP
- SSL certificates (self-signed)
- WordPress salts

Secrets are mounted into containers using Docker secrets for enhanced security.

---

## ♻️ Alpine Version Auto-Update

To ensure you're always using the penultimate stable version of Alpine Linux, run:

```bash
make update
```

---

## 📜 License

This project is built as part of the 42 School "Inception" project.

