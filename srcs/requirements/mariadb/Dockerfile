FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y mariadb-server && \
    apt-get clean

RUN mkdir -p /var/run/mysqld && \
    chown mysql:mysql /var/run/mysqld

COPY ./tools/mariadb.sh /tools/mariadb.sh
RUN chmod +x /tools/mariadb.sh

ENTRYPOINT ["/tools/mariadb.sh"]
