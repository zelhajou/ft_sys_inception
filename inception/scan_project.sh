#!/bin/bash

# Function to read file content if it exists
read_file() {
    if [ -f "$1" ]; then
        echo "File: $1"
        echo "<file_content>"
        cat "$1"
        echo "</file_content>"
        echo
    fi
}

# Create project structure overview
echo "Project Structure:"
echo "<directory_structure>"
tree
echo "</directory_structure>"
echo

# Read Makefile
echo "<makefile>"
read_file "Makefile"
echo "</makefile>"

# Read docker-compose.yml
echo "<docker_compose>"
read_file "srcs/docker-compose.yml"
echo "</docker_compose>"

# Read MariaDB files
echo "<mariadb_files>"
read_file "srcs/requirements/mariadb/Dockerfile"
read_file "srcs/requirements/mariadb/conf/my.cnf"
read_file "srcs/requirements/mariadb/tools/docker-entrypoint.sh"
echo "</mariadb_files>"

# Read NGINX files
echo "<nginx_files>"
read_file "srcs/requirements/nginx/Dockerfile"
for conf_file in srcs/requirements/nginx/conf/*; do
    read_file "$conf_file"
done
for tool_file in srcs/requirements/nginx/tools/*; do
    read_file "$tool_file"
done
echo "</nginx_files>"

# Read WordPress files
echo "<wordpress_files>"
read_file "srcs/requirements/wordpress/Dockerfile"
for conf_file in srcs/requirements/wordpress/conf/*; do
    read_file "$conf_file"
done
for tool_file in srcs/requirements/wordpress/tools/*; do
    read_file "$tool_file"
done
echo "</wordpress_files>"

# Read any .env file if it exists
echo "<env_file>"
read_file "srcs/.env"
echo "</env_file>"