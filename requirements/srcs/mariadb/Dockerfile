FROM debian:12.2
ARG DB_NAME
ARG DB_ROOT
ARG DB_USER
ARG DB_PASS
RUN apt update && apt upgrade -y
RUN apt install mariadb-server
COPY ./components/db_setup.sh ./
RUN chmod +x db_setup.sh
ENTRYPOINT ["db_setup.sh"]