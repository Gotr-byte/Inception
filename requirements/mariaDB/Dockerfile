FROM debian:12

# Update and install MariaDB
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

# Copy your script to initialize and run MariaDB (if you have one)
COPY create_db.sh /usr/local/bin/create_db.sh
RUN chmod +x /usr/local/bin/create_db.sh

EXPOSE 3306

# Initialize and run MariaDB (this is a basic example, adapt as necessary)
CMD ["create_db.sh"]