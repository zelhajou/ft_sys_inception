FROM alpine:3.18

# Install required packages
RUN apk update && apk add --no-cache \
    php81 \
    php81-fpm \
    php81-mysqli \
    php81-json \
    php81-curl \
    php81-dom \
    php81-exif \
    php81-fileinfo \
    php81-mbstring \
    php81-openssl \
    php81-xml \
    php81-zip \
    php81-phar \
    mysql-client \
    wget \
    unzip 


# Install wp-cli
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Configure php-fpm
COPY conf/www.conf /etc/php81/php-fpm.d/www.conf

# Configure SSMTP
RUN echo "sendmail_path = /bin/true" > /etc/php81/conf.d/mail.ini

# Create wordpress directory
RUN mkdir -p /var/www/html

# Set working directory
WORKDIR /var/www/html

# Copy entrypoint script
COPY tools/wordpress-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wordpress-entrypoint.sh

# Expose port 9000
EXPOSE 9000

ENTRYPOINT ["wordpress-entrypoint.sh"]

CMD ["/usr/sbin/php-fpm81", "-F"]