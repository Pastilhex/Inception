FROM debian:bullseye

RUN apt update
RUN apt install nginx -y
RUN apt install vim -y
RUN mkdir -p /etc/nginx/ssl
RUN apt install openssl -y
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/inception.key -out /etc/nginx/ssl/inception.crt -subj "/C=PT/ST=OPO/L=Porto/O=42"

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/ialves-m.conf /etc/nginx/sites-available

RUN ln -s /etc/nginx/sites-available/ialves-m.conf /etc/nginx/sites-enabled/ialves-m.conf
RUN mkdir -p /var/www/html/ialves-m
RUN chmod 755 /var/www/html/ialves-m

RUN chown -R www-data:www-data /var/www/html/ialves-m

CMD ["nginx", "-g", "daemon off;"]