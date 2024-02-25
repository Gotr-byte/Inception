FROM debian:bookworm

# Install MariaDB Server
# DEBIAN_FRONTEND=noninteractive this environment variable is set to make sure that the package installation process doesn't prompt the user for input.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

# Expose port 3306 for the MySQL daemon
EXPOSE 3306

# Copy entrypoint script into the image
COPY ./script/entrypoint.sh /root/

# Use entrypoint script to start services
ENTRYPOINT ["/bin/bash", "/root/entrypoint.sh"]
