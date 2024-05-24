#!/bin/bash

if [ ! -d "/var/lib/mysql/my_db" ]; then
	mysqld_safe --datadir=/var/lib/mysql --user=mysql

	sleep 2

    # Setup user and database
    mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};" -h localhost
    mysql -u root -e "CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';" -h localhost
    mysql -u root -e "GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';" -h localhost
    mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}'; FLUSH PRIVILEGES;" -h localhost
    
    # Shutdown the server
    mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown
fi

exec mysqld --bind-address=0.0.0.0 --user=mysql
