#! /bin/bash

sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = wordpress:9000|' /etc/php/7.4/fpm/pool.d/www.conf

mkdir -p /run/php/
chown www-data:www-data /run/php

if [ ! -f /var/www/html/ialves-m/wordpress/wp-config.php ]; then

    echo "Installing WP-CLI... wait a moment"
    wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp && \
    chmod +x /usr/local/bin/wp

    mkdir -p /var/www/html/ialves-m/wordpress
    cd /var/www/html/ialves-m/wordpress
    
	wget -q https://wordpress.org/latest.tar.gz
	tar -xvf latest.tar.gz --strip-components=1
	
	# wp core download --allow-root

    sleep 2
    
    # wp config create --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD} --dbhost=${MYSQL_HOST} --allow-root
    wp config create --dbname=my_db --dbuser=my_user --dbpass=my_pass --dbhost=mariadb --path=/var/www/html/ialves-m/wordpress --allow-root
    wp core install --url="$WP_URL" \
	--title="$WP_TITLE" \
	--admin_user="$WP_ADMIN_USER" \
	--admin_password="$WP_ADMIN_PASSWORD" \
    --admin_email="$WP_ADMIN_EMAIL" \
	--skip-email --allow-root
    wp user create $WP_USER $WP_USER_EMAIL \
	--role=author --user_pass=$WP_USER_PASSWORD \
	--allow-root

else 
    echo "Wordpress already installed and configured"
fi

# echo "Access WordPress site here: https://ialves-m.42.fr"
# service php7.4-fpm stop

exec /usr/sbin/php-fpm7.4 -F

# sleep 330
