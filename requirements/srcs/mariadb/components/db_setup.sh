#! /bin/bash

service mariadb start
mysql -u root -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
mysql -u root -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';\
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' ;\
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT' ;\
FLUSH PRIVILEGES;"
service mariadb stop
sudo mysqld --user=root --bind-address=0.0.0.0
