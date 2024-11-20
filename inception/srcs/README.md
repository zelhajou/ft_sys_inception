# Docker Compose File Syntax

## Basic Structure
```yaml
services:
```
- `services`: The top-level key that contains all service definitions
- In Docker Compose, a service is a container configuration

## MariaDB Service Configuration

```yaml
mariadb:
```
- Defines a service named "mariadb"
- This name becomes the hostname in the Docker network
- Other containers can reach this service using this name

```yaml
  image: mariadb
```
- `image`: Specifies the base image name
- This is the image that will be built using the Dockerfile

```yaml
  build:
    context: requirements/mariadb
    dockerfile: Dockerfile
```
- `build`: Configuration for building the Docker image
- `context`: The path to the directory containing the build context
  - Sets the working directory for the build
  - All paths in the Dockerfile are relative to this directory
- `dockerfile`: Specifies which Dockerfile to use for building
  - Default is `Dockerfile` if not specified

```yaml
  container_name: mariadb
```
- `container_name`: Sets a custom name for the container
- Without this, Docker would generate a random name
- Must be unique across all containers

```yaml
  volumes:
    - mariadb_data:/var/lib/mysql
```
- `volumes`: Defines volume mappings
- Syntax: `<volume_name>:<container_path>`
- `mariadb_data`: References the volume defined in the volumes section
- `/var/lib/mysql`: The path inside the container where the volume is mounted

```yaml
  networks:
    - inception_network
```
- `networks`: Specifies which networks the container joins
- `-inception_network`: The name of the network (defined in networks section)
- Uses YAML array notation (hyphen prefix)

```yaml
  env_file:
    - .env
```
- `env_file`: Specifies a file containing environment variables
- `.env`: The path to the environment file relative to docker-compose.yml
- Variables in this file are loaded into the container

```yaml
  restart: always
```
- `restart`: Defines the container's restart policy
- `always`: Container will restart automatically in all cases except manual stop

## WordPress Service Configuration

```yaml
wordpress:
  image: wordpress
  build:
    context: requirements/wordpress
    dockerfile: Dockerfile
```
- Similar structure to MariaDB service
- Builds custom WordPress image with PHP-FPM

```yaml
  depends_on:
    - mariadb
```
- `depends_on`: Defines service dependencies
- Ensures MariaDB starts before WordPress
- Does not guarantee application-level readiness

## NGINX Service Configuration

```yaml
  ports:
    - "443:443"
```
- `ports`: Maps container ports to host ports
- Syntax: `"<host_port>:<container_port>"`
- Exposes HTTPS port 443 to the host machine

## Networks Section

```yaml
networks:
  inception_network:
    driver: bridge
```
- `networks`: Top-level key for network definitions
- `inception_network`: Custom network name
- `driver`: Specifies the network driver
  - `bridge`: Default driver
  - Creates isolated network for containers
  - Enables DNS resolution between containers

## Volumes Section

```yaml
volumes:
  wordpress_data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: ${VOLUME_PATH}/wordpress
```
- `volumes`: Top-level key for volume definitions
- `wordpress_data`: Name of the volume
- `driver`: Specifies the volume driver
  - `local`: Uses local filesystem storage
- `driver_opts`: Driver-specific options
  - `type: none`: Specifies a bind mount
  - `o: bind`: Mount option for bind mount
  - `device`: The host path to mount
    - Uses environment variable `${VOLUME_PATH}`

## Environment Variables Used

The `${VARIABLE_NAME}` syntax references variables from the .env file:
- `${VOLUME_PATH}`: Base path for volume storage
- `${DOMAIN_NAME}`: Domain name for the website
- Database credentials:
  - `${MYSQL_ROOT_PASSWORD}`
  - `${MYSQL_DATABASE}`
  - `${MYSQL_USER}`
  - `${MYSQL_PASSWORD}`
- WordPress configuration:
  - `${WORDPRESS_DB_HOST}`
  - `${WORDPRESS_DB_NAME}`
  - `${WORDPRESS_DB_USER}`
  - `${WORDPRESS_DB_PASSWORD}`
  - `${WORDPRESS_URL}`
  - `${WORDPRESS_TITLE}`
  - `${WORDPRESS_ADMIN_USER}`
  - `${WORDPRESS_ADMIN_EMAIL}`
  - `${WORDPRESS_ADMIN_PASSWORD}`

## Key Docker Compose Version 3 Features Used

1. **Service Configuration:**
   - Build configuration
   - Container naming
   - Network attachment
   - Volume mounting
   - Environment variables
   - Restart policies
   - Port mapping

2. **Networking Features:**
   - Custom networks
   - Service discovery
   - DNS resolution

3. **Volume Management:**
   - Named volumes
   - Bind mounts
   - Driver options

4. **Dependency Management:**
   - Service dependencies
   - Startup order

## Validation Commands

To validate and debug the Docker Compose file:
```bash
# Validate syntax
docker-compose config

# Check for errors
docker-compose -f docker-compose.yml config

# View resolved configuration
docker-compose convert
```
