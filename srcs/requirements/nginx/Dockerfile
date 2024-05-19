FROM debian:bullseye

RUN apt update
RUN apt install nginx -y
RUN apt install vim -y
RUN mkdir -p /etc/nginx/ssl
RUN apt install openssl -y
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=PT/ST=OPO/L=Porto/O=42"


