FROM debian:bullseye

RUN apt update
RUN apt install nginx -y
RUN apt install vim -y
RUN apt-get install mariadb-server -y

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

