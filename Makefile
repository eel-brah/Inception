SRC_DIR=srcs
DOCKER_COMPOSE=docker-compose -f $(SRC_DIR)/docker-compose.yml

all: build up

build: 
	@$(DOCKER_COMPOSE) build
	@mkdir -p /home/$(USER)/data/wordpress_files
	@mkdir -p /home/$(USER)/data/wordpress_db
	@mkdir -p /home/$(USER)/data/website_files

up: generate_secrets 
	@$(DOCKER_COMPOSE) up -d 

down:
	@$(DOCKER_COMPOSE) down

logs:
	@$(DOCKER_COMPOSE) logs -f

clean:
	@$(DOCKER_COMPOSE) down -v --remove-orphans

logs-service:
	@$(DOCKER_COMPOSE) logs -f $(service)

fclean: clean
	@$(DOCKER_COMPOSE) down --rmi all
	@rm -rf ./secrets/*
	@sudo rm -rf /home/$(USER)/data/wordpress_files
	@sudo rm -rf /home/$(USER)/data/wordpress_db
	@sudo rm -rf /home/$(USER)/data/website_files

shell:
	@$(DOCKER_COMPOSE) exec $(service) sh

restart: down build up

re: fclean build up

ps:
	@$(DOCKER_COMPOSE) ps

update:
	@./srcs/requirements/tools/update.sh

generate_secrets:
	@./srcs/requirements/tools/generate_secrets.sh

help:
	@echo "Available targets:"
	@echo "  all       - Build and start the services (default)"
	@echo "  build     - Build Docker images"
	@echo "  up        - Start the services"
	@echo "  down      - Stop and remove containers and networks"
	@echo "  clean     - Stop and remove containers, networks, volumes"
	@echo "  logs      - View logs for all services"
	@echo "  logs-service - View logs for a specific service (e.g., make logs-service service=wordpress)"
	@echo "  shell     - Open a shell in a running container (e.g., make shell service=wordpress)"
	@echo "  re        - Rebuild and restart the services"
	@echo "  ps        - List running containers"
	@echo "  update    - Update all Dockerfile to use the penultimate stable version of alpine"
	@echo "  generate_secrets - Generate ssl, passwords and wp keys/salts"
	@echo "  help      - Show this help message"

.PHONY: up build down clean logs restart fclean re ps generate_secrets
