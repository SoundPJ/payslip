ON ?= PRODUCTION

NAME				= payslip
COMPOSE				= compose
DOCKER				= docker
EXEC				= exec
YML_BASE			= ./docker-compose.yml
YML_DEVELOPMENT		= ./docker-compose.dev.yml
YML_PRODUCTION		= ./docker-compose.prod.yml
NETWORK				= $(NAME)-application
WEB_IMAGE			= $(NAME)-web:latest
DB_IMAGE			= postgres:15
NGINX_IMAGE			= nginx:alpine
MIGRATE_IMAGE		= $(NAME)-migrate:latest
NODE_MODULES		= node_modules
NEXT_CACHE			= next_cache
DATA_VOLUME			= postgres_data
MiGRATE_DEV			= npx prisma migrate dev --name
DATABASE_CONTAINER	= postgres_db
WEB_CONTAINER		= payslip_web
# MIGRATE_CONTAINER	=

NORMAL	= \033[0m
GREEN	= \033[1;32m
ORANGE	= \033[1;33m
BLUE	= \033[1;36m
RED		= \033[1;31m

ifeq ($(ON),DEVELOPMENT)
COMPOSE_FILE = -f $(YML_BASE) -f $(YML_DEVELOPMENT)
else
COMPOSE_FILE = -f $(YML_BASE) -f $(YML_PRODUCTION)
endif

all:
	$(DOCKER) $(COMPOSE) $(COMPOSE_FILE) up --build
.PHONY: all

detach:
	$(DOCKER) $(COMPOSE) $(COMPOSE_FILE) up -d --build
	@echo "$(GREEN):::::: DEPLOYED SUCCESS ::::::$(NORMAL)"
.PHONY: detach

down:
	$(DOCKER) $(COMPOSE) $(COMPOSE_FILE) down
.PHONY: down

migrate:
	$(DOCKER) $(EXEC) $(WEB_CONTAINER) $(MiGRATE_DEV) $(UPDATE)
.PHONY: migrate

list:
	@echo "$(ORANGE)========================================================================================$(NORMAL)"
	@echo "$(ORANGE)================================:::::: CONTIANERS ::::::================================$(NORMAL)\n"
	@docker ps -a
	@echo "$(ORANGE)========================================================================================$(NORMAL)"
	@echo "$(ORANGE)================================:::::::: IMAGES ::::::::================================$(NORMAL)"
	@docker images
	@echo "$(ORANGE)========================================================================================$(NORMAL)"
	@echo "$(ORANGE)================================:::::::: VOLUMES :::::::================================$(NORMAL)\n"
	@docker volume list
	@echo "$(ORANGE)========================================================================================$(NORMAL)"
	@echo "$(ORANGE)================================::::::: NETWORKS :::::::================================$(NORMAL)\n"
	@docker network list
	@echo "$(ORANGE)========================================================================================$(NORMAL)"
.PHONY: list

clean: down
	@docker volume rm $(NAME)_$(NODE_MODULES) $(NAME)_$(NEXT_CACHE)
.PHONY: clean

fclean: clean
	@docker image rm $(WEB_IMAGE) $(DB_IMAGE) $(MIGRATE_IMAGE) $(NGINX_IMAGE)
	@docker volume rm $(NAME)_$(DATA_VOLUME)
	@docker network rm $(NETWORK)
.PHONY: fclean

re: down all
.PHONY: re
