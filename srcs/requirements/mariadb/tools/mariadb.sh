#!/bin/bash

# Check if the database directory does not exist
if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
    # Start MySQL server in the background
    mysqld_safe --user=mysql --datadir=/var/lib/mysql --pid-file=/var/run/mysqld/mysqld.pid --socket=/var/run/mysqld/mysqld.sock &

    # Wait until the MySQL server is ready to accept connections
    while ! mysqladmin ping -h localhost --silent; do
        sleep 1
    done

    # From here, the MySQL server is ready to accept connections

    # Create the database if it does not exist
    mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};" -h localhost
    
    # Create the database user if it does not exist, and set the password
    mysql -u root -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" -h localhost
    
    # Grant all privileges to the user on the database
    mysql -u root -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" -h localhost
    
    # Change the MySQL root user password
    mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}'; FLUSH PRIVILEGES;" -h localhost
    
    # Shutdown the MySQL server
    mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown
fi

# Start the MySQL server
exec mysqld --bind-address=0.0.0.0 --user=mysql
