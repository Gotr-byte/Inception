#!/bin/bash

if [ ! -e /root/.not_first_run ]; then
    touch /root/.not_first_run
    sed -i 's/bind-address\s*=\s*127\.0\.0\.1/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf
		service mariadb start
		while ! mysqladmin ping -h "$MARIADB_HOST" --silent; do
    	sleep 1
		done
		INITIALIZATION_STATEMENTS="CREATE DATABASE wordpress; CREATE USER 'your_user'@'%' IDENTIFIED BY 'your_password'; GRANT ALL PRIVILEGES ON wordpress.* TO 'your_user'@'%' IDENTIFIED BY 'your_password' WITH GRANT OPTION; FLUSH PRIVILEGES;"
		mysql -u root --password="" -e "$INITIALIZATION_STATEMENTS"
		service mariadb stop
fi
exec mysqld_safe
