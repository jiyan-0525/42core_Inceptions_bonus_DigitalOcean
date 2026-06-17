# Variable
COMPOSE_FILE = srcs/docker-compose.yml
DATA_DIR = /home/$(USER)/data

all: build
	docker compose -f $(COMPOSE_FILE) up -d

# Create data directories
$(DATA_DIR)/mariadb:
	mkdir -p $(DATA_DIR)/mariadb

$(DATA_DIR)/wordpress:
	mkdir -p $(DATA_DIR)/wordpress

$(DATA_DIR)/portainer:
	mkdir -p $(DATA_DIR)/portainer

# Build images
build: $(DATA_DIR)/mariadb $(DATA_DIR)/wordpress $(DATA_DIR)/portainer
	docker compose -f $(COMPOSE_FILE) build

# Start services
up:
	docker compose -f $(COMPOSE_FILE) up -d

restart:
	docker compose -f $(COMPOSE_FILE) restart

# Stop services
down:
	docker compose -f $(COMPOSE_FILE) down

# Clean containers and images
clean:
	docker compose -f $(COMPOSE_FILE) down --rmi all

# Full clean including volumes
fclean: clean
	sudo rm -rf $(DATA_DIR)
	docker system prune -af

re: fclean all

.PHONY: all build up down clean fclean re
