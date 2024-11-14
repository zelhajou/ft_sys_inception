#!/bin/bash
set -eo pipefail

# Function to replace environment variables in SQL files
process_sql_files() {
    for sql_file in /docker-entrypoint-initdb.d/*.sql; do
        if [ -f "$sql_file" ]; then
            # Create a temporary file with environment variables replaced
            tmp_file=$(mktemp)
            envsubst < "$sql_file" > "$tmp_file"
            
            echo "Executing $sql_file..."
            /usr/bin/mysqld --user=mysql --bootstrap < "$tmp_file"
            rm -f "$tmp_file"
        fi
    done
}

# Check if database directory is empty
if [ -z "$(ls -A /var/lib/mysql)" ]; then
    # Initialize MySQL data directory
    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null

    # Process and execute all SQL files
    process_sql_files
fi

# Start MariaDB server
exec mysqld --user=mysql