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

# Setup WordPress
WORKDIR /var/www/html
RUN wp core download --allow-root && \
    wp config create --dbname=mysql --dbuser=your_user --dbpass=your_password --dbhost=mariadb --allow-root
EXPOSE 9000
RUN wp core install --url=pbiederm.42.fr --title=Inception --admin_user=your_user --admin_password=your_password --admin_email=pbiederm@student.42wolfsburg.de --allow-root

# CMD [/bin/bash]

# todo get wordpress command line
# curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# make the wp-cli.phar executable
# chmod +x wp-cli.phar
# sudo mv wp-cli.phar /usr/local/bin/wp
# setup wordpress so it connects with mariadb
# test wordpress
