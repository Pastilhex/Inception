FROM debian:bullseye

RUN apt-get update && apt-get install -y wget curl php7.4-fpm php7.4-mysqli

COPY /tools/entrypoint.sh /tools/entrypoint.sh

RUN chmod +x /tools/entrypoint.sh

# RUN	apt install curl -y && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
#
# RUN	chmod +x wp-cli.phar && mv wp-cli.phar /usr/bin/wp

EXPOSE 9000

ENTRYPOINT [ "/tools/entrypoint.sh" ]
