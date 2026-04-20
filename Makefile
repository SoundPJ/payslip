NAME			= payslip
COMPOSE			= compose
DOCKER			= docker
YML_BASE		= ./docker-compose.yml
YML_DEVELOPMENT	= ./docker-compose.dev.yml
YML_PRODUCTION	= ./docker-compose.prop.yml

NORMAL	= \033[0m
GREEN	= \033[1;32m
ORANGE	= \033[1;33m
BLUE	= \033[1;36m
RED		= \033[1;31m

all:
	$(DOCKER) $(COMPOSE) -f $(YML_BASE) -f $(YML_DEVELOPMENT) up -d
	@echo "$(GREEN):::::: DEPLOYED SUCCESS ::::::$(NORMAL)"

console:
	$(DOCKER) $(COMPOSE) -f $(YML_BASE) -f $(YML_DEVELOPMENT) up

dev:
	$(DOCKER) $(COMPOSE) -f $(YML_BASE) -f $(YML_DEVELOPMENT) up

down:
	$(DOCKER) $(COMPOSE) -f $(YML) down

list:
	@echo "$(GREEN):::::: CONTIANERS ::::::$(NORMAL)"
	@docker ps -a
	@echo "$(GREEN):::::::: IMAGES ::::::::$(NORMAL)"
	@docker images
	@echo "$(GREEN)::::::: NETWORKS :::::::$(NORMAL)"
	@docker network list
	@echo "$(GREEN):::::::: VOLUMES :::::::$(NORMAL)"
	@docker volime list

clean: down
	@echo down
# 	@docker images rm 

re: down clean

.PHONY: all dev down list clean re console


