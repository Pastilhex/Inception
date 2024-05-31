#!/bin/bash

if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then

    mkdir -p /run/mysqld
    chown mysql:mysql /run/mysqld

    mysqld_safe --user=mysql --datadir=/var/lib/mysql --pid-file=/var/run/mysqld/mysqld.pid --socket=/var/run/mysqld/mysqld.sock & # --log-error=/var/log/mysql/error.log &
    
    # while ! mysqladmin ping -h localhost --silent; do
    #     sleep 1
    # done
    
    mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};" -h localhost
    mysql -u root -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" -h localhost
    mysql -u root -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" -h localhost
    mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}'; FLUSH PRIVILEGES;" -h localhost

    # mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown
fi

exec mysqld --bind-address=127.0.0.1 --port=3306 --user=mysql
