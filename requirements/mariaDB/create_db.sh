#!/bin/bash

# Start MariaDB
mysqld_safe &

# Wait a bit for the server to start
sleep 10

# Create a new database named 'exampledb'
mysql -u root -e "CREATE DATABASE IF NOT EXISTS exampledb;"

# Create a table in the 'exampledb' database
mysql -u root -e "
USE exampledb;
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    position VARCHAR(100),
    salary DECIMAL(10, 2)
);"

# Keep the container running
tail -f /dev/null
