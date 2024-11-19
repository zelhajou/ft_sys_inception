#!/bin/bash
set -e

wait_for_mariadb() {
    echo "Waiting for MariaDB to be ready..."
    while ! mysqladmin ping -h"$WORDPRESS_DB_HOST" -u"$WORDPRESS_DB_USER" -p"$WORDPRESS_DB_PASSWORD" --silent; do
        echo "MariaDB is unavailable - sleeping"
        sleep 5
    done
    echo "MariaDB is up and running!"
}

wait_for_mariadb

if [ ! -f wp-config.php ]; then
    echo "WordPress configuration not found. Installing WordPress..."

    if [ ! -f index.php ]; then
        wp core download --allow-root
    fi

    wp config create \
        --dbname=$WORDPRESS_DB_NAME \
        --dbuser=$WORDPRESS_DB_USER \
        --dbpass=$WORDPRESS_DB_PASSWORD \
        --dbhost=$WORDPRESS_DB_HOST \
        --allow-root

    wp core install \
        --url=$WORDPRESS_URL \
        --title=$WORDPRESS_TITLE \
        --admin_user=$WORDPRESS_ADMIN_USER \
        --admin_password=$WORDPRESS_ADMIN_PASSWORD \
        --admin_email=$WORDPRESS_ADMIN_EMAIL \
        --allow-root
    
    wp user create \
        $WORDPRESS_USER \
        $WORDPRESS_USER_EMAIL \
        --role=author \
        --user_pass=$WORDPRESS_USER_PASSWORD \
        --allow-root
    echo "WordPress installation completed!"
else
    echo "WordPress is already installed."
fi

echo "Starting PHP-FPM..."
exec "$@"