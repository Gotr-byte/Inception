The following project is about creating a LEMP stack wchich consists of Linux, (E)nginx, Mariadb, WordPress.

All of the elements are places in seperate docker containers.

There is a docker network and two volumes: one for the MariaDb container one for Wordpress.

#todo write documetation 

In order to run username.42.fr you need to change the /env/hosts file. Add 127.0.0.1
Managed to get wordpress to start. Installed wordpress cli. Need to setup the /etc/php/8.2/fpm/pool.d/www.conf file. Set listen to 0.0.0.0:9000. Add more pm values.

#Run the following to start php-fpm
/usr/sbin/php-fpm8.2 -F

Need to create a wordpress database or upload a ready database.

#create a docker volume
docker volume create wp_files

# create a docker network
docker network create inception

#Inside srcs/requirements/mariadb folder build the mariadb container
docker build -t mariadb:00 --network=inception .

#Run the mariadb container
docker run -d --name mariadb --network=inception mariadb:00

#Inside srcs/requirements/wordpress folder to build the wordpress container

docker build -t wordpress:01 --network=inception .
docker run -it --name wordpress --network=inception wordpress:01

#Run with the volumes
docker run -it --name wordpress --network=inception -v wp_files:/var/www/html wordpress:01

#In the srcs/requirements/nginx folder
docker build --network=inception -t nginx:02 .
docker run --name nginx --network=inception -v wp_files:/var/www/html:ro -p 443:443 nginx:02

Now I need to run it in the schools virtual machines, remember not to post .env file in schools git. Rememeber to change the volume folder to the one specified in the assignment.