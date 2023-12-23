#! ./bin/bash

# wp config create --dbname=databasename --dbuser=username --dbpass=password --dbhost=localhost --dbprefix=wp_
wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=mariadb --dbprefix=wp_
# wp core install --url="your_domain.com" --title="Your Site Title" --admin_user="username" --admin_password="password" --admin_email="you@domain.com"
# wp user create $DB_USER $EMAIL --role=author --user_pass=$WP_PASS --allow-root
/usr/sbin/php-fpm8.2 -F