FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y mariadb-server && \
    apt-get clean

RUN mkdir -p /run/mysqld && \
    chown mysql:mysql /run/mysqld

COPY ./tools/mariadb.sh /mariadb.sh
RUN chmod +x /mariadb.sh

ENTRYPOINT [ "sh", "/mariadb.sh" ]
