FROM debian:bullseye

RUN apt update
RUN apt install nginx -y
RUN apt install vim -y
RUN apt-get install mariadb-server -y

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY conf/mariadb.sh /etc/mysql/mariadb.conf.d/mariadb.sh

RUN chmod +x /etc/mysql/mariadb.conf.d/mariadb.sh
RUN /etc/mysql/mariadb.conf.d/mariadb.sh
