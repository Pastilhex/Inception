#! /bin/bash

# Replace PHP-FPM configuration to listen on port 9000
sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = wordpress:9000|' /etc/php/7.4/fpm/pool.d/www.conf

# Create necessary directory for PHP-FPM
mkdir -p /run/php/

# Download and install WP-CLI
wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp && chmod +x /usr/local/bin/wp

# Check if wp-config.php file does not exist
if [ ! -f /var/www/html/ialves-m/wordpress/wp-config.php ]; then

    # Create WordPress directory if it does not exist and navigate to it
    mkdir -p /var/www/html/ialves-m/wordpress
    cd /var/www/html/ialves-m/wordpress
    
    # Download WordPress core
	wp core download --allow-root

    # Set a timeout for waiting for WordPress to be downloaded
    timeout=30
    while [ $timeout -gt 0 ]; do
        if [ -f wp-load.php ]; then
            echo "WordPress core downloaded successfully."
            break
        fi
        sleep 1
        timeout=$((timeout - 1))
    done

    # Check if timeout was reached
    if [ $timeout -eq 0 ]; then
        echo "Error: WordPress core download verification timed out."
        exit 1
    fi

    # Create WordPress configuration file
    wp config create --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD} --dbhost=${MYSQL_HOST} --allow-root

    # Install WordPress
    wp core install --url="$WP_URL" \
	--title="$WP_TITLE" \
	--admin_user="$WP_ADMIN" \
	--admin_password="$WP_ADMIN_PASSWORD" \
    --admin_email="$WP_ADMIN_EMAIL" \
	--skip-email --allow-root

    # Create a WordPress user
    wp user create $WP_USER $WP_USER_EMAIL \
	--role=author --user_pass=$WP_USER_PASSWORD \
	--allow-root

else
    echo "WordPress already installed and configured"
fi

# Start PHP-FPM in daemon mode
exec /usr/sbin/php-fpm7.4 -F
