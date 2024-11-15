#!/bin/bash
set -eo pipefail

echo "Starting MariaDB initialization..."

# Initialize database if needed
if [ -z "$(ls -A /var/lib/mysql)" ]; then
    echo "Initializing MariaDB data directory..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null

    echo "Starting temporary MariaDB server..."
    mysqld --user=mysql --datadir=/var/lib/mysql &
    pid="$!"

    echo "Waiting for MariaDB to become available..."
    until mysqladmin ping >/dev/null 2>&1; do
        sleep 1
    done

    echo "Configuring MariaDB users and databases..."
    mysql -u root << EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';

CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;

CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';

DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';

FLUSH PRIVILEGES;
EOF

    echo "Stopping temporary MariaDB server..."
    kill -s TERM "$pid"
    wait "$pid"
fi

echo "Starting MariaDB server..."
exec mysqld --user=mysql