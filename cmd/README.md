## 1. Project Management (using Makefile)

```makefile
# Build and start everything
make all

# Just build the containers
make build

# Start the services
make up

# Stop the services
make down

# Check status of containers, images, volumes, and networks
make status

# View logs
make logs

# Clean everything (including volumes and images)
make fclean

# Rebuild everything from scratch
make re
```

## 2. Container Management

```dockerfile
# List running containers
docker ps

# List all containers (including stopped)
docker ps -a

# Stop specific container
docker stop nginx
docker stop wordpress
docker stop mariadb

# Start specific container
docker start nginx
docker start wordpress
docker start mariadb

# Access container shell
docker exec -it nginx sh
docker exec -it wordpress sh
docker exec -it mariadb sh

# View container logs
docker logs nginx
docker logs wordpress
docker logs mariadb

# Follow container logs
docker logs -f nginx
```

## 3. Network Management

```dockerfile
# List networks
docker network ls

# Inspect network
docker network inspect inception_network
```

## 4. Volume Management

```dockerfile
# List volumes
docker volume ls

# Inspect volume
docker volume inspect src_wordpress_data
docker volume inspect src_mariadb_data

# If you need to inspect the volume on the host
ls -la /home/$USER/data/mariadb

# Remove specific volume
docker volume rm src_wordpress_data
docker volume rm src_mariadb_data

# Remove all unused volumes
docker volume prune
```

## 5. Image Management

```dockerfile
# List images
docker images

# Remove specific image
docker rmi nginx
docker rmi wordpress
docker rmi mariadb

# Remove all unused images
docker image prune
```

## 6. Docker Compose Commands (from srcs directory)

```dockerfile
# Build and start services
docker compose up -d

# Stop services
docker compose down

# Build services
docker compose build

# Show service logs
docker compose logs

# Show running services
docker compose ps

# Restart services
docker compose restart
```

## 7. Debugging Commands:

```dockerfile
# Check container resource usage
docker stats

# Inspect container configuration
docker inspect nginx
docker inspect wordpress
docker inspect mariadb

# View container processes
docker top nginx
docker top wordpress
docker top mariadb
```

## 8. Cleanup Commands:

```dockerfile
# Remove all stopped containers
docker container prune

# Remove all unused volumes
docker volume prune

# Remove all unused networks
docker network prune

# Remove everything unused
docker system prune -a --volumes
```

## 9. WordPress Specific Commands:

```dockerfile
# Access WordPress container and run WP-CLI commands
docker exec -it wordpress wp user list --allow-root
docker exec -it wordpress wp plugin list --allow-root
docker exec -it wordpress wp theme list --allow-root
```

## 10. Database (MariaDB) Specific Commands:

```dockerfile
# Access MariaDB
docker exec -it mariadb mysql -u$MYSQL_USER -p$MYSQL_PASSWORD

# Backup database
docker exec mariadb mysqldump -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE > backup.sql

# Restore database
docker exec -i mariadb mysql -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE < backup.sql
```

**DataBase Commands:**

```mysql
# Show all Users
SELECT User FROM mysql.user;

# Show all databases
SHOW DATABASES;

# Create a new database
CREATE DATABASE <database_name>;


# Show all databases
SHOW DATABASES;

# Use a database
USE <database_name>;

# Show all tables in a database
SHOW TABLES;
```

## 11. Miscellaneous Commands:

```dockerfile
# Check Docker version
docker version

# Check Docker info
docker info

# Check Docker disk usage
docker system df
```

## 12. Docker Hub Commands:

```dockerfile
# Login to Docker Hub
docker login

# Push image to Docker Hub
docker push <username>/<image_name>:<tag>

# Pull image from Docker Hub
docker pull <username>/<image_name>:<tag>
```