FROM debian:12.2
ARG DB_NAME
ARG DB_ROOT
ARG DB_USER
ARG DB_PASS
RUN apt update &&\
		apt upgrade -y &&\
		apt install php-fpm8.2 &&\
		apt-get install php-mysql -y &&\
		apt install wget -y

# Move the following to a script, that which is not in a form of a dependency.
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
# RUN wp core install --allow-root
RUN wp cli update --allow-root
# RUN wp config create --dbname=databasename --dbuser=username --dbpass=password --dbhost=localhost --dbprefix=wp_
COPY ./components/wp-setup.sh ./
RUN chmod +x wp-setup.sh
ENTRYPOINT ["wp-setup.sh"]