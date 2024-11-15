FROM alpine:3.18

# Install nginx and required packages
RUN apk update && apk add --no-cache \
    nginx \
    openssl

# Create directory for SSL certificates
RUN mkdir -p /etc/nginx/ssl

# Generate self-signed SSL certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=zelhajou.42.fr"

# Create directory for nginx pid file
RUN mkdir -p /run/nginx

# Copy nginx configuration
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/default.conf /etc/nginx/http.d/default.conf

# Expose port 443
EXPOSE 443

# Start nginx
CMD ["nginx", "-g", "daemon off;"]