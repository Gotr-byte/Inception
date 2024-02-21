FROM debian:bookworm
RUN apt-get update && apt-get install -y mariadb-server
RUN 	mkdir -p /var/lib/mysqld /run/mysqld
RUN		chown -R mysql:mysql /var/lib/mysql
RUN 	chown -R mysql:mysql /run/mysqld
EXPOSE 3306
COPY entrypoint.sh /root/
ENTRYPOINT ["/bin/bash", "/root/entrypoint.sh"] 