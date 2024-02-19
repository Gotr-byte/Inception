#!/bin/bash

if [ ! -e /root/.not_first_run ]; then
    touch /root/.not_first_run
    sed -i 's/bind-address\s*=\s*127\.0\.0\.1/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf
		service mariadb start
		service mariadb enable
    INITIALIZATION_STATEMENTS="CREATE USER 'your_user'@'172.17.0.1' IDENTIFIED BY 'your_password'; GRANT ALL PRIVILEGES ON *.* TO 'your_user'@'172.17.0.1' IDENTIFIED BY 'your_password' WITH GRANT OPTION; FLUSH PRIVILEGES;"
    mysql -u root --password="" -e "$INITIALIZATION_STATEMENTS"
fi
exec /bin/bash