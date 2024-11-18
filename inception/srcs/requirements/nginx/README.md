## Nginx Dockerfile

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
- Uses Alpine Linux 3.19 as base image
- Alpine is chosen for its small size (~5MB) and security
- Version 3.19 specified for stability (avoiding 'latest' tag as required)


### 2. Core Components - Nginx, OpenSSL

**NGINX**:

- High-performance web server, reverse proxy, and load balancer
- Key features:

    - Serves static content efficiently
    - Handles concurrent connections well
    - Acts as reverse proxy for dynamic content
    - Provides load balancing
    - Manages SSL/TLS termination

- Why used in this project:

    - Required as the entry point for the infrastructure
    - Handles HTTPS connections
    - Routes requests to WordPress
    - Manages static file serving

**OpenSSL**:

- Cryptography and SSL/TLS toolkit
- Provides:
    - SSL/TLS protocol implementation
    - Cryptographic functions
    - Certificate management tools

- Why needed:
    - Generates SSL/TLS certificates
    - Enables HTTPS support
    - Required for secure communication

```dockerfile
# Package installation
RUN apk update && apk add --no-cache \
    nginx \
    openssl \
```
- `apk update` Updates the package index
- `--no-cache` Doesn't store the package cache, reducing image size
- Packages installed:
    - `nginx`: The core web server
    - `openssl`: Required for HTTPS configuration


### 3. SSL Certificate Generation

**SSL/TLS Certificates:**\

- Purpose:

    - Encrypts data in transit
    - Authenticates server identity
    - Prevents man-in-the-middle attacks

- Certificate Components:

    - Private Key (nginx.key):

        - Kept secret
        - Used to decrypt incoming messages
        - Signs server responses

    - Public Certificate (nginx.crt):

        - Shared with clients
        - Contains server's public key
        - Includes identity information

- Generation Parameters:
    - x509: Self-signed certificate standard
    - nodes: No password protection
    - days 365: One year validity
    - rsa:2048: 2048-bit RSA key (strong encryption)
    - CN: Common Name (domain identity)

```dockerfile
# SSL Certificate setup
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/CN=${DOMAIN_NAME:-localhost}"
```

- Creates SSL directory
- Generates self-signed certificate:
  - -x509: Self-signed cert format
  - -nodes: No password protection for private key
  - -days 365: Valid for one year
  - -newkey rsa:2048: New 2048-bit RSA key
  - -keyout: Private key location
  - -out: Certificate location
  - -subj: Certificate subject, uses DOMAIN_NAME from env or defaults to localhost

### 4. NGINX Configuration

```dockerfile
# Configuration file copy
COPY srcs/nginx.conf /etc/nginx/conf.d/default.conf
```

- Copies custom NGINX configuration
- Defines:

    - Server behavior
    - SSL settings
    - WordPress integration
    - Security parameters


### 5. Port Configuration

```dockerfile
# Expose ports
EXPOSE 443
```
- HTTPS standard port
- Project requirement: only port 443 allowed
- TLS requirement:

    - Must use TLSv1.2 or TLSv1.3
    - Older versions prohibited for security

### 6. Container Runtime

```dockerfile
# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
```
- Starts Nginx in the foreground
- `-g "daemon off;"`: Keeps Nginx in the foreground for Docker
- Required for Docker to manage the process