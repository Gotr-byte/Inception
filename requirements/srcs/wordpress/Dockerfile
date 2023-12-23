

FROM debian:12.2
RUN apt update &&\
		apt upgrade -y &&\
		apt install php-fpm &&\
		apt-get install php-mysql -y &&\
		apt install wget -y &&\
# RUN mkdir -p /var/www/html/example.com
# RUN cd /var/www/html/example.com
# RUN wget https://wordpress.org/latest.tar.gz
# RUN tar -xvzf latest.tar.gz
# RUN chown -R nginx: /var/www/html/example.com
# COPY ./components/wp-config.php ./
# RUN cd /
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN wp core download --allow-root
RUN wp core install --allow-root
RUN wp cli update --allow-root
RUN wp config create --dbname=databasename --dbuser=username --dbpass=password --dbhost=localhost --dbprefix=wp_