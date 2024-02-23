FROM debian:bookworm

# Install MariaDB Server
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/lib/mysql /run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /run/mysqld

# Expose port 3306 for the MySQL daemon
EXPOSE 3306

# Copy entrypoint script into the image
COPY entrypoint.sh /root/

# Use entrypoint script to start services
ENTRYPOINT ["/bin/bash", "/root/entrypoint.sh"]
