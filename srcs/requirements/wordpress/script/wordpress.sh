if [ ! -e /root/.not_first_run ]; then
    touch /root/.not_first_run
		sleep 5 
		wp core download --allow-root && \
    wp config create --dbname=wordpress --dbuser=your_user --dbpass=your_password --dbhost=mariadb --allow-root
		wp core install --url=pbiederm.42.fr --title=Inception --admin_user=your_user --admin_password=your_password --admin_email=pbiederm@student.42wolfsburg.de --allow-root --skip-email
		wp plugin update --all --allow-root
		wp theme install twentysixteen --activate --allow-root
fi
php-fpm8.2 --nodaemonize