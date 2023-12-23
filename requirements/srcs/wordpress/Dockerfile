FROM debian:12.2
ARG DB_NAME
ARG DB_ROOT
ARG DB_USER
ARG DB_PASS
ARG EMAIL
RUN apt update &&\
		apt upgrade -y &&\
		apt install php-fpm8.2 -y&&\
		apt install php-mysql -y &&\
		apt install wget -y &&\
		apt install curl
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN wp core download --allow-root
RUN wp cli update --allow-root
COPY ./components/wp-setup.sh ./
RUN chmod +x wp-setup.sh
ENTRYPOINT ["wp-setup.sh"]