if [ ! -f .not_first_run ]; then
    wp core download --allow-root
    wp config create --dbname=wordpress --dbuser=your_user --dbpass=your_password --dbhost=mariadb --allow-root
    wp core install --url=$DOMAIN_NAME --title=Inception --admin_user=$MYSQL_USER --admin_password=$MYSQL_PASSWORD --admin_email=$ADMIN_EMAIL --allow-root --skip-email
		wp user create $SECOND_USER $SECOND_USER_EMAIL --role=author --user_pass=$SECOND_USER_PASSWORD --allow-root
    wp theme install twentysixteen --activate
    wp plugin update --all

    touch .not_first_run
fi

php-fpm8.2 --nodaemonize