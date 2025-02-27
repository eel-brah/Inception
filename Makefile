SRC_DIR=srcs
DOCKER_COMPOSE=docker-compose -f $(SRC_DIR)/docker-compose.yml

up: generate_secrets 
	$(DOCKER_COMPOSE) up -d

down:
	$(DOCKER_COMPOSE) down

build: generate_secrets
	$(DOCKER_COMPOSE) build

logs:
	$(DOCKER_COMPOSE) logs -f

clean:
	$(DOCKER_COMPOSE) down -v

restart: down up

fclean: clean
	docker system prune -a --volumes
	# docker secret ls -q | xargs docker secret rm

re: fclean up

ps:
	docker ps

update:
	./srcs/requirements/tools/update.sh

generate_secrets:
	./srcs/requirements/tools/generate_secrets.sh

.PHONY: up build down clean logs restart fclean re ps generate_secrets
