# First time setup and start
make all

# To see logs
make logs

# To stop containers
make down

# To rebuild everything
make rebuild

# Check if container is running
docker ps

# Connect to container
docker exec -it mariadb bash

# Test MariaDB connection
# Inside container
mysql -u wpuser -p
# Enter the password: wppass123

# Test the database
-- Inside MySQL prompt
SHOW DATABASES;
USE wordpress;


# Troubleshooting tips:
# 1. If containers don't start, check logs:
docker logs

# 2. If you need to check container's status:
docker ps -a

# 3. If you need to inspect the volume:
ls -la /home/$USER/data/mariadb


# 4. If you need to reset everything:
make clean
make all