# Variables
DOCKER_COMPOSE = cd srcs && docker-compose
DATA_PATH = /home/${USER}/data
WORDPRESS_DATA = $(DATA_PATH)/wordpress
MARIADB_DATA = $(DATA_PATH)/mariadb

# Colors for pretty printing
GREEN = \033[0;32m
YELLOW = \033[1;33m
NC = \033[0m

all: setup build up

setup:
	@echo "$(GREEN)Creating necessary directories...$(NC)"
	@sudo mkdir -p $(WORDPRESS_DATA)
	@sudo mkdir -p $(MARIADB_DATA)
	@sudo chmod 777 $(WORDPRESS_DATA)
	@sudo chmod 777 $(MARIADB_DATA)
	@echo "$(YELLOW)Setting up hosts file...$(NC)"
	@if ! grep -q "zelhajou.42.fr" /etc/hosts; then \
		echo "127.0.0.1 zelhajou.42.fr" | sudo tee -a /etc/hosts; \
	fi

build:
	@echo "$(GREEN)Building containers...$(NC)"
	@$(DOCKER_COMPOSE) build

up:
	@echo "$(GREEN)Starting containers...$(NC)"
	@$(DOCKER_COMPOSE) up -d

down:
	@echo "$(GREEN)Stopping containers...$(NC)"
	@$(DOCKER_COMPOSE) down -v 2>/dev/null || true
	@docker rm -f $$(docker ps -aq) 2>/dev/null || true

clean: 
	@echo "$(GREEN)Cleaning up containers and volumes...$(NC)"
	@$(DOCKER_COMPOSE) down -v 2>/dev/null || true
	@docker rm -f $$(docker ps -aq) 2>/dev/null || true
	@docker volume rm $$(docker volume ls -q) 2>/dev/null || true
	@docker network prune -f 2>/dev/null || true
	@sudo rm -rf $(DATA_PATH)
	@sudo sed -i '/zelhajou.42.fr/d' /etc/hosts

fclean: clean
	@echo "$(GREEN)Deep cleaning Docker system...$(NC)"
	@docker system prune -af

ps:
	@$(DOCKER_COMPOSE) ps

logs:
	@$(DOCKER_COMPOSE) logs -f

reload: down up

rebuild: fclean all

.PHONY: all setup build up down clean fclean ps logs reload rebuild