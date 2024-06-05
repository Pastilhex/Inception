FROM debian:bullseye

RUN apt-get update && apt-get install -y wget curl php7.4-fpm php7.4-mysqli

COPY /tools/entrypoint.sh /tools/entrypoint.sh

RUN chmod +x /tools/entrypoint.sh

EXPOSE 9000

ENTRYPOINT [ "/tools/entrypoint.sh" ]
