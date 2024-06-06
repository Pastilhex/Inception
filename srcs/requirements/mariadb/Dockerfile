# Set the base image to Debian Bullseye
FROM debian:bullseye

# Update the package repository and install MariaDB server
RUN apt-get update && apt-get install -y mariadb-server && apt-get clean

# Create a directory for MariaDB's socket file and set ownership to the mysql user
RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

# Copy the script for initializing MariaDB to the container
COPY ./tools/mariadb.sh /mariadb.sh

# Grant execute permission to the script
RUN chmod +x /mariadb.sh

# Set the entry point to the script for initializing MariaDB
ENTRYPOINT [ "sh", "/mariadb.sh" ]
