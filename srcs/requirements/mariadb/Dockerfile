FROM debian:bullseye

# Install MariaDB
RUN apt-get update && \
    apt-get install -y mariadb-server && \
    apt-get clean

# Criar o diretório para o socket do MariaDB e ajustar permissões
RUN mkdir -p /var/run/mysqld && \
    chown mysql:mysql /var/run/mysqld

COPY ./tools/mariadb.sh /tools/mariadb.sh
RUN chmod +x /tools/mariadb.sh

# Set the entrypoint script as the default command
ENTRYPOINT ["/tools/mariadb.sh"]