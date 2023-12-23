mkdir inception
cd inception
touch Makefile
echo 'all : up

up : 
	@docker-compose -f ./srcs/docker-compose.yml up -d

down : 
	@docker-compose -f ./srcs/docker-compose.yml down

stop : 
	@docker-compose -f ./srcs/docker-compose.yml stop

start : 
	@docker-compose -f ./srcs/docker-compose.yml start

status : 
	@docker ps' > Makefile
mkdir requirements
cd requirements
touch docker-compose.yaml
echo 'version: "3"
services:
  nginx:
    build: ./srcs/nginx
    ports:
      - "443:443"
    restart: always
    networks:
      ohyeah:
  wordpress:
    image: wordpress
    ports:
      - "9000:80"
    depends_on:
      - mysql
    environment:
      WORDPRESS_DB_HOST: mysql
      WORDPRESS_DB_USER: root
      WORDPRESS_DB_PASSWORD: "coffe"
      WORDPRESS_DB_NAME: wordpress
    networks:
      ohyeah:
  mysql:
    image: "mysql:5.7"
    environment:
      MYSQL_DATABASE: wordpress
      MYSQL_ROOT_PASSWORD: "coffe"
    volumes:
      - ./mysql:/var/lib/mysql
    networks:
      ohyeah:
networks:
  ohyeah:
    ipam:
        driver: default
        config:
' > docker-compose.yaml
mkdir srcs
cd srcs
mkdir nginx
cd nginx
touch Dockerfile
echo 'FROM debian:12
RUN apt-get update && \
		apt-get upgrade -y && \
		apt-get install -y nginx openssl
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
RUN openssl req -x509 -nodes -newkey rsa:4096 -days 365 \
		-out /etc/ssl/certs/pbiederm.42.fr.crt \
		-keyout /etc/ssl/private/pbiederm.42.fr.key \
		-subj "/C=DE/ST=wob/L=Germany/O=42/OU=42/CN=pbiederm.42.fr/UID=pbiederm/" && \
CMD ["nginx", "-g", "daemon off;"]' > Dockerfile
mkdir conf
cd conf
touch nginx.conf
echo 'events {}
http {
    include /etc/nginx/mime.types;
    server {
        listen 443 ssl;
        server_name  pbiederm.42.fr www.pbiederm.42.fr;

        root /var/www/html;
        index index.html;
        ssl_certificate     /etc/ssl/certs/pbiederm.42.fr.crt;
        ssl_certificate_key /etc/ssl/private/pbiederm.42.fr.key;
        ssl_protocols       TLSv1.2 TLSv1.3;

        location / {
            try_files $uri $uri/ /index.php?$args;
        }
        
        location ~ \.php$ {
            fastcgi_pass my-wordpress-container:9000;
            fastcgi_index index.php;
            include fastcgi_params;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
            fastcgi_param PATH_INFO $fastcgi_path_info;
        }
    }
}
' > nginx.conf
cd ../..
mkdir mariadb
cd mariadb
touch Dockerfile
mkdir components
touch ./components/script.sh
cd ..
mkdir wordpress
cd wordpress
touch Dockerfile
mkdir components
