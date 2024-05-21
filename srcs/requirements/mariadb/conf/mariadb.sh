#!/bin/bash

service mysql start

mysql -e "CREATE DATABASE IF NOT EXISTS \`my_sql\`;"
mysql -e "CREATE USER IF NOT EXISTS \`my_user\`@'localhost' IDENTIFIED BY 'my_pass';"
mysql -e "GRANT ALL PRIVILEGES ON \`my_sql\`.* TO \`my_user\`@'%' IDENTIFIED BY 'my_pass';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'my_root_pass';"
mysql -e "FLUSH PRIVILEGES;"
mysqladmin -u root -p"my_root_pass" shutdown

exec mysqld_safe

# mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
# mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
# mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
# mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
# mysql -e "FLUSH PRIVILEGES;"
# mysqladmin -u root -p"${SQL_ROOT_PASSWORD}" shutdown