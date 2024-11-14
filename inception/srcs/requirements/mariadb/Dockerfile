
FROM alpine:3.19

# Install MariaDB and required packages
RUN apk update && apk add --no-cache \
    mariadb \
    mariadb-client \
    mariadb-common \
    bash \
    gettext \
    && mkdir -p /run/mysqld \
    && chown -R mysql:mysql /run/mysqld \
    && mkdir -p /var/lib/mysql \
    && chown -R mysql:mysql /var/lib/mysql


# Copy configuration
COPY conf/my.cnf /etc/my.cnf.d/mariadb-server.cnf

# Copy entrypoint script
COPY tools/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Create directory for socket and grant permissions
RUN mkdir -p /var/run/mysqld \
    && chown -R mysql:mysql /var/run/mysqld \
    && chmod 777 /var/run/mysqld

# Expose MariaDB port
EXPOSE 3306

# Set entrypoint
ENTRYPOINT ["docker-entrypoint.sh"]

# Start MariaDB
CMD ["mysqld", "--user=mysql"]