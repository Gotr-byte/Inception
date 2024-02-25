#!/bin/bash
if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

if [ ! -d "/var/lib/mysql/mysql" ]; then
	
	chown -R mysql:mysql /var/lib/mysql
fi
if [ ! -e /root/.not_first_run ]; then
    touch /root/.not_first_run
    sed -i 's/bind-address\s*=\s*127\.0\.0\.1/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf
		service mariadb start
		while ! mysqladmin ping -h "$MARIADB_HOST" --silent; do
    	sleep 1
		done
		INITIALIZATION_STATEMENTS="CREATE DATABASE $MYSQL_DATABASE; CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' WITH GRANT OPTION; FLUSH PRIVILEGES;"
		mysql -u root --password="" -e "$INITIALIZATION_STATEMENTS"
		service mariadb stop
fi
exec mysqld_safe
