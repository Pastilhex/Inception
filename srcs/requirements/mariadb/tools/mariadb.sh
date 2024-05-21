#!/bin/bash

if [ ! -d "/var/lib/mysql/my_db" ]; then
echo "Initializing database..."

service mariadb start

sleep 2

mysql_secure_installation << END
Y
my_root_pass
my_root_pass
Y
Y
Y
Y
END

# Start the server in the background
# mysqld_safe --datadir=/var/lib/mysql --user=mysql &

    sleep 2

    # Setup user and database
    mysql -e "CREATE DATABASE IF NOT EXISTS my_db;" -h localhost
    mysql -e "CREATE USER IF NOT EXISTS 'my_user'@'%' IDENTIFIED BY 'my_pass';" -h localhost
    mysql -e "GRANT ALL PRIVILEGES ON my_db.* TO 'my_user'@'%' IDENTIFIED BY 'my_pass';" -h localhost
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'my_root_pass'; FLUSH PRIVILEGES;" -h localhost

    # Shutdown the server
    mysqladmin -u root -pmy_root_pass shutdown


    # Start the server
fi

exec mysqld --bind-address=0.0.0.0 --user=mysql



# #!/bin/bash

# sleep 2

# # export SQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
# # export SQL_PASSWORD=$(cat /run/secrets/db_password)
# # export SQL_DATABASE=$(cat /run/secrets/db_name)

# # Initialize database if necessary
# if [ ! -d "/var/lib/mysql/${SQL_DATABASE}" ]; then
#     echo "Initializing database..."

#     # Start the server in the background
#     mysqld_safe --datadir=/var/lib/mysql --user=mysql &
#     sleep 5

#     # Setup user and database
#     mysql -e "CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};" -h localhost
#     mysql -e "CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';" -h localhost
#     mysql -e "GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';" -h localhost
#     mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}'; FLUSH PRIVILEGES;" -h localhost
    
#     # Shutdown the server
#     mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown
# else
#     echo "Database already initialized"
# fi

# # Start the server
# exec mysqld --bind-address=0.0.0.0 --user=mysql