# Start from the Debian image
FROM debian:12

# Install PHP and other required packages
RUN apt-get update && apt-get install -y \
    php \
    php-fpm \
    php-mysql \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Download and set up WordPress
RUN wget https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz \
    && mv wordpress /var/www/html/wordpress \
    && rm latest.tar.gz

# Expose the port for PHP-FPM
EXPOSE 9000

# Configure PHP-FPM to run in the foreground
CMD ["php-fpm7.4", "-F"]