SRC_DIR=src
DOCKER_COMPOSE=docker-compose -f $(SRC_DIR)/docker-compose.yml

up:
	$(DOCKER_COMPOSE) up -d

down:
	$(DOCKER_COMPOSE) down

build:
	$(DOCKER_COMPOSE) build

logs:
	$(DOCKER_COMPOSE) logs -f

clean:
	$(DOCKER_COMPOSE) down -v

restart: down up

fclean: clean
	docker system prune -a --volumes

re: fclean all

ps:
	docker ps

.PHONY: up build down clean logs restart fclean re ps
