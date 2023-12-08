CERTS_DIR=./requirements/nginx/tools

define IMG

░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
░░░░░░▄ ▀▄▄▀▄░░░░░░░░░░░░░░░░░░░░░▄ ▀▄▄▀▄░░░░░░░░░░░░░░░░░░░░░▄ ▀▄▄▀▄░░░░░░░░░░░░░░
░░░░░█░░░░░░░░▀▄░░░░░░▄░░░░░░░░░░█░░░░░░░░▀▄░░░░░░▄░░░░░░░░░░█░░░░░░░░▀▄░░░░░░▄░░░░
░░░░█░░▀░░▀░░░░░▀▄▄░░█░█░░░░░░░░█░░▀░░▀░░░░░▀▄▄░░█░█░░░░░░░░█░░▀░░▀░░░░░▀▄▄░░█░█░░░
░░░░█░▄░█▀░▄░░░░░░░▀▀░░█░░░░░░░░█░▄░█▀░▄░░░░░░░▀▀░░█░░░░░░░░█░▄░█▀░▄░░░░░░░▀▀░░█░░░
░░░░█░░▀▀▀▀░░░░░░░░░░░░█░░░░░░░░█░░▀▀▀▀░░░░░░░░░░░░█░░░░░░░░█░░▀▀▀▀░░░░░░░░░░░░█░░░
░░░░█░░░░░░░░░░░░░░░░░░█░░░░░░░░█░░░░░░░░░░░░░░░░░░█░░░░░░░░█░░░░░░░░░░░░░░░░░░█░░░
░░░░█░░░░░░░░░░░░░░░░░░█░░░░░░░░█░░░░░░░░░░░░░░░░░░█░░░░░░░░█░░░░░░░░░░░░░░░░░░█░░░
░░░░░█░░▄▄░░▄▄▄▄░░▄▄░░█░░░░░░░░░░█░░▄▄░░▄▄▄▄░░▄▄░░█░░░░░░░░░░█░░▄▄░░▄▄▄▄░░▄▄░░█░░░░
░░░░░█░▄▀█░▄▀░░█░▄▀█░▄▀░░░░░░░░░░█░▄▀█░▄▀░░█░▄▀█░▄▀░░░░░░░░░░█░▄▀█░▄▀░░█░▄▀█░▄▀░░░░
*Barf*



endef
export IMG
db-volumes:
	docker volume create db_data
wordpress-volumes:
	docker volume create wordpress_data
network:
	docker network create LEMP-net
mariadb-build:
	docker build -t mariadb ./requirements/mariaDB
mariadb-run:
	docker run -d -p 3306:3306 --network LEMP-net mariadb
mariadb-run-alt:
	docker run -d \
	-p 3306:3306 \
  --name mariadb \
  --network LEMP-net \
  -v db_data:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=secret \
  -e MYSQL_DATABASE=wordpress \
  -e MYSQL_USER=wordpress \
  -e MYSQL_PASSWORD=wordpress \
  mariadb
wordpress-build:
	docker build -t this-wordpress ./requirements/wordpress
wordpress-run:
	docker run -d -p 9000:9000 --network LEMP-net this-wordpress
wordpress-run-alt:
	docker run -d \
	--name wordpress_container \
	--network LEMP-net \
	-v wordpress_data \
	-p 9000:9000 \
	-e WORDPRESS_DB_HOST=mariadb_container \
	-e WORDPRESS_DB_USER=wordpress_user \
	-e WORDPRESS_DB_PASSWORD=wordpress_pass \
	-e WORDPRESS_DB_NAME=wordpress \
	this-wordpress
nginx-build:
	docker build -t this-nginx ./requirements/nginx
nginx-run:
	docker run -d -p 443:443 this-nginx
nginx-run-alt:
	docker run -d -p 443:443 --network LEMP-net this-nginx

certs:
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout $(CERTS_DIR)/pbiederm.42.fr.key -out $(CERTS_DIR)/pbiederm.42.fr.crt \
	-subj "/C=US/ST=State/L=City/O=Organization/CN=pbiederm.42.fr.com"

clean:
	docker system prune -a
	rm ./requirements/nginx/tools/pbiederm.42.fr.crt
	rm ./requirements/nginx/tools/pbiederm.42.fr.key
fclean:	clean
re:		fclean all

CROSS = "\033[8m"
RED = "\033[0;1;91m"
GREEN = "\033[0;1;32m"
BLUE = "\033[0;1;34m"

.PHONY: clean fclean re