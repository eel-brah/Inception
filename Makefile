SRC_DIR=srcs
DOCKER_COMPOSE=docker-compose -f $(SRC_DIR)/docker-compose.yml
SSL_DIR=$(SRC_DIR)/requirements/nginx/ssl
SSL_KEY=$(SSL_DIR)/nginx.key
SSL_CRT=$(SSL_DIR)/nginx.crt

up: generate-ssl
	$(DOCKER_COMPOSE) up -d

down:
	$(DOCKER_COMPOSE) down

build: generate-ssl
	$(DOCKER_COMPOSE) build

logs:
	$(DOCKER_COMPOSE) logs -f

clean:
	$(DOCKER_COMPOSE) down -v

restart: down up

fclean: clean
	docker system prune -a --volumes

re: fclean up

ps:
	docker ps

generate-ssl:
	@if [ ! -f $(SSL_KEY) ] || [ ! -f $(SSL_CRT) ]; then \
		echo "Generating SSL certificates..."; \
		mkdir -p $(SSL_DIR); \
		openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
			-keyout $(SSL_KEY) \
			-out $(SSL_CRT) \
			-subj "/C=MA/ST=State/L=City/O=Org/CN=localhost"; \
	else \
		echo "SSL certificates already exist."; \
	fi


.PHONY: up build down clean logs restart fclean re ps generate-ssl
