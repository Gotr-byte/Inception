FROM debian:bookworm

# Install PHP and extensions, and clean up in one layer
# possible additional packages: apt install php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip php-imagick
RUN apt-get update && \
    apt-get install -y \
    wget \
	curl \
	bash \
	php8.2 \
	php8.2-cgi \
	php8.2-mysql \
	php8.2-fpm \
	php8.2-pdo \
	php8.2-gd php8.2-cli \
	php8.2-mbstring \
	redis \
	php8.2-redis \
	&& rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Download and install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/
# RUN mkdir /run/php
# Setup WordPress
WORKDIR /var/www/html
EXPOSE 9000
COPY ./script/wordpress.sh .
ENTRYPOINT ["/bin/bash", "wordpress.sh"]
