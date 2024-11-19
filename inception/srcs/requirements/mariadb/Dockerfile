FROM alpine:3.19

RUN apk update && apk add --no-cache \
    mariadb \
    mariadb-client \
    mariadb-common \
    bash

RUN mkdir -p /run/mysqld && \
    mkdir -p /var/lib/mysql && \
    mkdir -p /var/log/mysql && \
    chown -R mysql:mysql /run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql && \
    chown -R mysql:mysql /var/log/mysql

COPY conf/my.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY tools/mariadb-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/mariadb-entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["mariadb-entrypoint.sh"]
CMD ["mysqld", "--user=mysql"]