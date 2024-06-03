
MARIADB		= mariadb
NGINX		= nginx
WORDPRESS	= wordpress
VOLUMES_PATH = /home/ialves-m
COMPOSE		= sudo docker compose -f srcs/docker-compose.yml
DOCKER		= sudo docker
include srcs/.env

HOST_NAME=ialves-m.42.fr
HOSTS_ENTRY=127.0.0.1 $(HOST_NAME)

.SILENT:

all: setup-hosts mkdir-data compose-build compose-up

start: compose-up

stop: compose-stop

clean: compose-clean

clean-data: clean
	sudo rm -rf $(VOLUMES_PATH)

re: clean all

logs:
	$(COMPOSE) logs

info:
	$(COMPOSE) ps -a
	$(DOCKER) images
	$(DOCKER) network ls
	$(DOCKER) volume ls

maria_shell:
	$(DOCKER) exec -it mariadb_conteiner /bin/bash

nginx-shell:
	$(DOCKER) exec -it nginx_conteiner /bin/bash

wordpress-shell:
	$(DOCKER) exec -it wordpress_conteiner /bin/bash
	
setup-hosts:
	@if ! grep -q $(HOST_NAME) /etc/hosts; then \
		echo $(HOSTS_ENTRY) | sudo tee -a /etc/hosts > /dev/null; \
		echo “Added $(HOST_NAME) to /etc/hosts”; \
	else \
		echo “$(HOST_NAME) already in /etc/hosts”; \
	fi

mkdir-data:
	sudo mkdir -p $(VOLUMES_PATH)/data/db $(VOLUMES_PATH)/data/wp

compose-build:
	$(COMPOSE) build --no-cache

compose-up:
	$(COMPOSE) up -d

compose-stop:
	$(COMPOSE) stop

compose-clean:
	$(COMPOSE) down --rmi all --volumes

sys-df:
	$(DOCKER) system df

.PHONY: all start stop clean clean-data re logs info mariadb-it nginx-it wordpress-it
