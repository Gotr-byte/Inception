FROM debian:12.2
ARG DB_NAME
ARG DB_ROOT
ARG DB_USER
ARG DB_PASS
RUN apt-get update &&\
	apt-get upgrade -y &&\
	apt-get install sudo -y &&\
	apt-get install mariadb-server -y
# COPY ./components/50-server.cnf /etc/mysql/mariadb.conf.d/
RUN sed -i 's_127.0.0.1_0.0.0.0_' /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./components/db_setup.sh /
RUN chmod +x db_setup.sh
ENTRYPOINT ["/db_setup.sh"]
