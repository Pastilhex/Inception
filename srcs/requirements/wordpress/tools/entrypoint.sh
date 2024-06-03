#! /bin/bash

sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = wordpress:9000|' /etc/php/7.4/fpm/pool.d/www.conf

mkdir -p /run/php/
chown www-data:www-data /run/php

wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp && chmod +x /usr/local/bin/wp

if [ ! -f /var/www/html/ialves-m/wordpress/wp-config.php ]; then

    mkdir -p /var/www/html/ialves-m/wordpress
    cd /var/www/html/ialves-m/wordpress
    wp core download --allow-root

    sleep 2

    wp config create --dbname="${MYSQL_DATABASE}" --dbuser="${MYSQL_USER}" --dbpass="${MYSQL_PASSWORD}" --dbhost="${MYSQL_HOST}" --allow-root

    wp core install --url="${WP_URL}" --title="${WP_TITLE}" --admin_user="${WP_ADMIN}" --admin_password="${WP_ADMIN_PASSWORD}" --admin_email="${WP_ADMIN_EMAIL}" --skip-email --allow-root

    wp user create "${WP_USER}" "${WP_USER_EMAIL}" --role=author --user_pass="${WP_USER_PASSWORD}" --allow-root


else 
    echo "Wordpress already installed and configured"
fi

exec /usr/sbin/php-fpm7.4 -F
