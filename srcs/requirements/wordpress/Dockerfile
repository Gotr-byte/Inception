FROM debian:bookworm

# Install PHP and extensions, and clean up in one layer
# possible additional packages: apt install php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip php-imagick
RUN apt-get update && \
    apt-get install -y php8.2 php8.2-fpm php8.2-mysql curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download and install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/
# Setup WordPress
WORKDIR /var/www/html
EXPOSE 9000
COPY ./script/wordpress.sh .
ENTRYPOINT ["/bin/bash", "wordpress.sh"]
