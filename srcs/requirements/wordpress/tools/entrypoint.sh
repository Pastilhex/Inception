#! /bin/bash

export SQL_PASSWORD=$(cat /run/secrets/db_password)
export SQL_DATABASE=$(cat /run/secrets/db_name)
export SQL_HOST=$(cat /run/secrets/db_host)
export WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)
export WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)

sed -i 's|listen = /run/php/php8.1-fpm.sock|listen = wordpress:9000|' /etc/php/8.1/fpm/pool.d/www.conf

mkdir -p /run/php/

if [ ! -f /var/www/html/wordpress/wp-config.php ]; then

    echo "Installing WP-CLI... wait a moment"
    wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp && \
    chmod +x /usr/local/bin/wp

    mkdir -p /var/www/html/wordpress
    cd /var/www/html/wordpress
    wp core download --allow-root

    sleep 2
    
    wp config create --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD} --dbhost=${MYSQL_HOST} --allow-root
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

echo "Access WordPress site here: https://ialves-m.42.fr"

exec php-fpm8.1 -F