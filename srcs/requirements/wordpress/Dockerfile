FROM debian:bullseye

RUN apt-get update && apt-get install -y wget php7.4-fpm php7.4-mysqli php7.4-cli 

COPY /tools/entrypoint.sh /tools/entrypoint.sh

RUN chmod +x /tools/entrypoint.sh

RUN	apt install curl -y && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN	chmod +x wp-cli.phar && mv wp-cli.phar /usr/bin/wp

ENTRYPOINT [ "/tools/entrypoint.sh" ]
