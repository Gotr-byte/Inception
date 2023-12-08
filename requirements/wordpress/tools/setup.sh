#!/bin/sh

# We will first check if the "/var/www/html" folder exists or not, if not we create it
if [ ! -d "/var/www/html" ]; then
  mkdir /var/www/html
fi

# We will cd into the folder
cd /var/www/html

# This downloads the WordPress core files, the option ( --allow-root ) will run the command as root
# and ( --version:5.8.1 ) specifies the version of WordPress that will get downloaded
# and ( --local=en_US ) sets the language of the installation to US English
wp core download --allow-root --version=5.8.1 --locale=en_US

# This will generate the WordPress configuration file, and the options ( --dbname, --dbuser, --dbpass, --dbhost )
# are just placeholders that will get replaced once the script runs
wp config create --allow-root --dbname=${WP_NAME} --dbuser=${WP_ADMIN_USER} --dbpass=${WP_PASSWORD} --dbhost=${WP_HOST}

# This will then install WordPress, and again, all the options are just placeholders that will get replaced
wp core install --allow-root --url=${WP_URL} --title=${WP_TITLE} --admin_user=${WP_ADMIN_USER} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL}

# This create a new WordPress user, and sets its role to author ( --role=author )
wp user create "${WP_USER}" "${WP_EMAIL}" --user_pass="${WP_PASSWORD}" --role=author

# This is the command that will keep WordPress up and running
exec php-fpm7 -F -R 