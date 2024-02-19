FROM debian:bookworm
RUN apt-get update && apt-get install -y mariadb-server
EXPOSE 3306
COPY entrypoint.sh /root/
ENTRYPOINT ["/bin/bash", "/root/entrypoint.sh"] 