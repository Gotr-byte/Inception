# Define the path to the docker-compose file
COMPOSE_FILE := srcs/docker-compose.yml

# Define docker-compose command with the file location
DC := docker-compose -f $(COMPOSE_FILE)

.PHONY: up down remove-images remove-volumes prune build run full-cycle cycle clean fclean

#first run
init:
	mkdir -p /home/iter/data/db_data42
	mkdir -p /home/iter/data/wp_files42
	$(DC) up -d
	
# Bring up the environment
up:
	$(DC) up -d

# Take down the environment
down:
	$(DC) down

# Remove all images
remove-images:
	docker rmi $$(docker images -q) --force

# Remove volumes
remove-volumes:
	$(DC) down -v

# Prune the system
prune:
	docker system prune -a --volumes

clean: down remove-images

fclean: down prune remove-volumes

# Build images
build:
	$(DC) build

# Run images (assuming 'up' implicitly runs the images after building)
run: up

# Make target to execute the full cycle (including removing volumes)
cycle: down remove-images build run

full-cycle: down remove-volumes prune build run
