#! ./bin/bash

mkdir /var/www/
mkdir /var/www/html

cd /var/www/html

wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=mariadb --dbprefix=wp_ --allow-root
wp core install --url="pbiederm.42.fr" --title="Your Site Title" --admin_user="$DB_USER" --admin_password="$DB_PASS" --admin_email="you@domain.com" --skip-email --allow-root
wp user create $WP_USER $EMAIL --role=author --user_pass=$WP_PASS --allow-root
wp theme install astra --activate --allow-root
sudo sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = 9000/' /etc/php/8.2/fpm/pool.d/www.conf
/usr/sbin/php-fpm8.2 -F