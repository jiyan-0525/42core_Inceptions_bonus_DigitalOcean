# Variable
COMPOSE_FILE = srcs/docker-compose.yml
DATA_DIR = /home/$(USER)/data

all: build up

# Create data directories
$(DATA_DIR)/mariadb:
	mkdir -p $(DATA_DIR)/mariadb

$(DATA_DIR)/wordpress:
	mkdir -p $(DATA_DIR)/wordpress

# Build images
build: $(DATA_DIR)/mariadb $(DATA_DIR)/wordpress
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
	docker compose -f $(COMPOSE_FILE) down
	docker system prune -af

# Full clean including volumes
fclean: clean
	docker volume prune -f
	sudo rm -rf $(DATA_DIR)

re: fclean all

.PHONY: all build up down clean fclean re