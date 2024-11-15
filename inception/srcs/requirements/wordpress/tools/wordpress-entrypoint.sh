#!/bin/sh
set -e

echo "Starting WordPress initialization..."

echo "Waiting for MariaDB to be ready..."
until mysql -h"$WORDPRESS_DB_HOST" -u"$WORDPRESS_DB_USER" -p"$WORDPRESS_DB_PASSWORD" -e "SELECT 1;" >/dev/null 2>&1; do
    echo "MariaDB is unavailable - sleeping"
    sleep 2
done

echo "MariaDB is up - proceeding with WordPress setup"

if [ ! -f wp-config.php ]; then
    echo "Downloading WordPress core..."
    wp core download --allow-root

    echo "Creating wp-config.php..."
    wp config create \
        --dbname="$WORDPRESS_DB_NAME" \
        --dbuser="$WORDPRESS_DB_USER" \
        --dbpass="$WORDPRESS_DB_PASSWORD" \
        --dbhost="$WORDPRESS_DB_HOST" \
        --allow-root

    echo "Installing WordPress..."
    wp core install \
        --url="$WORDPRESS_URL" \
        --title="$WORDPRESS_TITLE" \
        --admin_user="$WORDPRESS_ADMIN_USER" \
        --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
        --admin_email="$WORDPRESS_ADMIN_EMAIL" \
        --allow-root

    if [ ! -z "$WORDPRESS_USER" ] && [ ! -z "$WORDPRESS_USER_EMAIL" ] && [ ! -z "$WORDPRESS_USER_PASSWORD" ]; then
        echo "Creating additional user..."
        wp user create "$WORDPRESS_USER" "$WORDPRESS_USER_EMAIL" \
            --role=author \
            --user_pass="$WORDPRESS_USER_PASSWORD" \
            --allow-root
    fi
fi

echo "Setting correct permissions..."
chown -R nobody:nobody /var/www/html

echo "Starting PHP-FPM..."
exec "$@"