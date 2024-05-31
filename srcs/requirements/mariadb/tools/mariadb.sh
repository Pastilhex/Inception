#!/bin/bash

# Check if all required environment variables are set
if [ -z "${MYSQL_DATABASE}" ] || [ -z "${MYSQL_USER}" ] || [ -z "${MYSQL_PASSWORD}" ] || [ -z "${MYSQL_ROOT_PASSWORD}" ]; then
    echo "Error: Missing required environment variables."
    exit 1
fi

echo "MYSQL_DATABASE=${MYSQL_DATABASE}"
echo "MYSQL_USER=${MYSQL_USER}"
echo "MYSQL_PASSWORD=${MYSQL_PASSWORD}"
echo "MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}"

# if [ ! -d "/var/lib/mysql/my_db" ]; then
if [ ! -d "/var/lib/mysql/'${MYSQL_DATABSE}'" ]; then
    # Create the /run/mysqld directory and set the correct permissions
    mkdir -p /run/mysqld
    chown mysql:mysql /run/mysqld

    # Start the MariaDB server
    mysqld_safe --user=mysql --datadir=/var/lib/mysql --pid-file=/var/run/mysqld/mysqld.pid --socket=/var/run/mysqld/mysqld.sock &
    
    # Increase the wait time to ensure the MariaDB server is ready
    sleep 5
    
    # Setup user and database
    # mysql -u root -e "CREATE DATABASE IF NOT EXISTS my_db;" -h localhost
    # mysql -u root -e "CREATE USER IF NOT EXISTS 'my_user'@'%' IDENTIFIED BY 'my_pass';" -h localhost
    # mysql -u root -e "GRANT ALL PRIVILEGES ON my_db.* TO 'my_user'@'%' IDENTIFIED BY 'my_pass';" -h localhost
    # mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'my_root_pass'; FLUSH PRIVILEGES;" -h localhost
    
    mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};" -h localhost
    mysql -u root -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" -h localhost
    mysql -u root -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" -h localhost
    mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}'; FLUSH PRIVILEGES;" -h localhost

    # Shutdown the server
    mysqladmin -u root -pmy_root_pass shutdown
fi

# Start the MariaDB server
exec mysqld --bind-address=0.0.0.0 --user=mysql
