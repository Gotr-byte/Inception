Start the service, create database and user with root, run mysqld to keep the database on.

Test build with the following:

docker build --build-arg DB_NAME=wordpress --build-arg DB_ROOT=rootpassword --build-arg DB_USER=wp_user --build-arg DB_PASS=userpassword -t mariadb-wordpress .

Test run with the following: 

docker run -d --name my-mariadb-container -p 3306:3306 mariadb-wordpress


