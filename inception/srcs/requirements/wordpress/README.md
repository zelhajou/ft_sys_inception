## Wordpress Dockerfile

### 1. Base System - Alpine Linux

- **What is Alpine?**
    - Ultra-lightweight Linux distribution (~5MB)
    - Based on musl libc and busybox
    - Popular for containers due to small size and security focus
    - Version 3.19 is the penultimate stable version as required by the project

```dockerfile
# Base image selection
FROM alpine:3.19
```

### 2. PHP and Dependencies Installation

```dockerfile
RUN apk update && apk add --no-cache \
    php81 \           # Base PHP package
    php81-fpm \       # FastCGI Process Manager
    php81-mysqli \    # MySQL/MariaDB connection support
    php81-json \      # JSON handling
    php81-curl \      # Remote HTTP requests
    php81-dom \       # XML/HTML manipulation
    php81-mbstring \  # Multi-byte string handling
    php81-openssl \   # SSL/TLS support
    php81-xml \       # XML processing
    php81-phar \      # PHP archive support
    php81-session \   # Session handling
    mariadb-client \  # MySQL/MariaDB client tools
    wget \           # File downloading
    bash            # Shell for scripts
```

- **PHP Extensions Explained:**
    - **php81-fpm**:

        - FastCGI Process Manager
        - Handles PHP processing
        - Communicates with NGINX
        - Better performance than mod_php

    - **php81-mysqli**:

        - MySQL/MariaDB database connectivity
        - Required for WordPress database operations
        - Secure database connections


    - **php81-json**:

        - JSON data handling
        - Used by WordPress API
        - Theme and plugin functionality


    - **php81-curl**:

        - Remote HTTP requests
        - Updates checking
        - External API integration
        - Plugin functionality

    - **php81-dom & php81-xml**:

        - XML/HTML processing
        - RSS feeds
        - Theme rendering
        - Plugin functionality


    - **php81-mbstring**:

        - Multi-byte string support
        - International character handling
        - Unicode support


    - php81-openssl:

        - SSL/TLS support
        - Secure communications
        - API authentication


    - **php81-session**:

        - User session management
        - Login functionality
        - State management

### 3. WordPress CLI Setup

```dockerfile
RUN mkdir -p /var/www/html && \
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp
```
- Creates web root directory
- Downloads WP-CLI tool
- Makes it executable
- Installs as system command

**WP-CLI Benefits:**

- Command-line WordPress management
- Automated installation
- Configuration management
- Plugin/theme management
- Database operations

### 4. Configuration Files

```dockerfile
COPY conf/www.conf /etc/php81/php-fpm.d/www.conf
COPY tools/wordpress-entrypoint.sh /usr/local/bin/
```

- PHP-FPM configuration
- Custom entrypoint script
- Runtime settings

### 5. Entrypoint Script Permissions

```dockerfile
RUN chmod +x /usr/local/bin/wordpress-entrypoint.sh
```

- Makes entrypoint executable
- Required for container startup

### 6. Working Directory

```dockerfile
WORKDIR /var/www/html
```

- Sets default directory
- WordPress installation location
- Web root directory

### 7. Port Configuration

```dockerfile
EXPOSE 9000
```

- PHP-FPM port
- Internal communication
- Used by NGINX

### 8. Container Startup

```dockerfile
ENTRYPOINT ["/usr/local/bin/wordpress-entrypoint.sh"]
CMD ["/usr/sbin/php-fpm81", "-F"]
```

- Runs initialization script
- Starts PHP-FPM in foreground



## **The Entrypoint Script (`wordpress-entrypoint.sh`):**
```bash
#!/bin/bash
set -e

# Wait for database
until mysql -h$WORDPRESS_DB_HOST -u$WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD -e "SELECT 1"; do
    echo "Waiting for MariaDB..."
    sleep 3
done

# WordPress installation
if [ ! -f wp-config.php ]; then
    wp core download --allow-root

    # Configure WordPress
    wp config create \
        --dbname=$WORDPRESS_DB_NAME \
        --dbuser=$WORDPRESS_DB_USER \
        --dbpass=$WORDPRESS_DB_PASSWORD \
        --dbhost=$WORDPRESS_DB_HOST \
        --allow-root

    # Install WordPress
    wp core install \
        --url=$WORDPRESS_URL \
        --title=$WORDPRESS_TITLE \
        --admin_user=$WORDPRESS_ADMIN_USER \
        --admin_password=$WORDPRESS_ADMIN_PASSWORD \
        --admin_email=$WORDPRESS_ADMIN_EMAIL \
        --allow-root
fi

exec "$@"
```

**Entrypoint Script Functions:**
1. Database Connection:
   - Waits for MariaDB availability
   - Ensures proper startup order
   - Prevents premature WordPress setup

2. WordPress Setup:
   - Downloads core files
   - Creates configuration
   - Performs initial installation
   - Sets up admin user

3. Environment Integration:
   - Uses environment variables
   - Configurable setup
   - Secure credential handling


## The www.conf File (`conf/www.conf`):

1. **Pool Name and User Settings**
```ini
[www]
user = nobody
group = nobody
```
- `[www]`: Default PHP-FPM pool name
- `user/group = nobody`: 
  - Runs processes as unprivileged user
  - Security best practice
  - Minimal permissions
  - Prevents unauthorized access

2. **Network Settings**
```ini
listen = 9000
```
- TCP port for PHP-FPM
- NGINX communicates here
- Internal network only
- FastCGI protocol

3. **Process Manager Configuration**
```ini
pm = dynamic
pm.max_children = 5
pm.start_servers = 2
pm.min_spare_servers = 1
pm.max_spare_servers = 3
```

**Process Manager Types:**
- `dynamic`: Adjusts workers based on load
- Alternatives:
  - `static`: Fixed number
  - `ondemand`: Created as needed

**Process Settings:**
- `max_children = 5`:
  - Maximum worker processes
  - Resource limit protection
  - Memory = 5 × PHP worker memory

- `start_servers = 2`:
  - Initial processes at startup
  - Balance between readiness/resources
  - < max_children

- `min_spare_servers = 1`:
  - Minimum idle workers
  - Always ready for requests
  - Prevents startup delay

- `pm.max_spare_servers = 3`:
  - Maximum idle workers
  - Resource efficiency
  - Must be < max_children

**Process Flow:**
1. Start with 2 servers
2. Scale up to 5 under load
3. Keep 1-3 idle servers
4. Balance performance/resources
