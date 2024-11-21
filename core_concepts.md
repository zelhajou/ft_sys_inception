## Core Concepts

### Process Management

#### PID 1 in Linux Systems
In a traditional Linux system, PID 1 (Process ID 1) is the init system (like systemd) and serves as the parent process for all other processes. It has three core responsibilities:
- Starting and stopping system services
- Handling signals (SIGTERM, SIGINT, SIGQUIT)
- Reaping zombie processes (cleaning up terminated processes)

#### PID 1 in Docker Containers
In Docker containers, PID 1 works differently than in a regular Linux system. Unlike a full OS, a container typically runs a single application process as PID 1.

**Example of Container Process Structure:**
```plaintext
Regular Linux System:        Docker Container:
PID 1 (init/systemd)        PID 1 (Your main process)
├── PID 2 (Service A)       └── Child processes
├── PID 3 (Service B)
└── PID 4 (Process C)
```
**Best Practices for Container Processes**

- **Bad Practices**:

	- Using shell scripts or hacky methods as PID 1:
		```dockerfile
		# DON'T: Using infinite loops
		CMD while true; do
			php-fpm
			sleep 1
		done

		# DON'T: Using tail -f
		CMD ["tail", "-f", "/dev/null"]
		```
	- Problems with these approaches:

		- Shell becomes PID 1 instead of the actual service
		- Signals aren't handled properly
		- Zombie processes aren't cleaned up
		- Container can't stop gracefully

- **Good Practices**:

	- Running the service directly as PID 1:
	
		```dockerfile
		# DO: Running PHP-FPM directly
		CMD ["/usr/sbin/php-fpm", "-F"]

		# DO: Running NGINX directly
		CMD ["nginx", "-g", "daemon off;"]
		```
		- Using ENTRYPOINT and CMD Together
	- For services that need initialization:
		```dockerfile
		# WordPress example
		ENTRYPOINT ["/usr/local/bin/wordpress-entrypoint.sh"]
		CMD ["/usr/sbin/php-fpm", "-F"]

		# Process structure:
		PID 1 (php-fpm)
		└── Worker processes
		```
- **Benefits of proper PID 1 implementation**:

	- Main service runs as PID 1
	- Proper signal handling
	- Clean process termination
	- Proper zombie process cleanup
	- Resource management
	- Container health monitoring


### Container Initialization

#### ENTRYPOINT vs CMD
Docker containers can be initialized using two main instructions: ENTRYPOINT and CMD. Understanding their differences and use cases is crucial for proper container setup.

##### ENTRYPOINT
- Defines the container's main executable
- Can't be easily overridden (requires `--entrypoint` flag)
- Best for containers with a specific purpose
- Used for required initialization processes

Example (MariaDB):
```dockerfile
ENTRYPOINT ["mariadb-entrypoint.sh"]
```
Common use cases:
- Database initialization
- Service configuration
- Environment setup

##### CMD
- Provides default arguments to ENTRYPOINT or default command
- Easily overridden via docker run commands or docker-compose
- Best for flexible behavior

Example (NGINX):
```dockerfile
CMD ["nginx", "-g", "daemon off;"]
```

##### Combining ENTRYPOINT and CMD
WordPress example showing both:
```dockerfile
ENTRYPOINT ["/usr/local/bin/wordpress-entrypoint.sh"]
CMD ["/usr/sbin/php-fpm81", "-F"]
```

#### Service Startup Patterns

##### 1. Direct Service Execution
Best for services that need minimal setup:
```dockerfile
# NGINX - Simple startup
CMD ["nginx", "-g", "daemon off;"]
```

##### 2. Initialization + Service
For services requiring setup before starting:
```bash
#!/bin/bash
# WordPress entrypoint example
# 1. Wait for database
until mysql -h$WORDPRESS_DB_HOST -u$WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD -e "SELECT 1"; do
    echo "Waiting for MariaDB..."
    sleep 3
done

# 2. Initialize if needed
if [ ! -f wp-config.php ]; then
    wp core download --allow-root
    wp config create \
        --dbname=$WORDPRESS_DB_NAME \
        --dbuser=$WORDPRESS_DB_USER \
        --dbpass=$WORDPRESS_DB_PASSWORD \
        --dbhost=$WORDPRESS_DB_HOST \
        --allow-root
fi

# 3. Start main process
exec "$@"
```

##### 3. Complex Service Setup
For services like databases that need comprehensive initialization:
```bash
# MariaDB initialization steps
1. Database system initialization
2. User creation
3. Permission setting
4. Database creation
5. Server startup
```

#### Overriding Default Behavior

##### Via Docker Run
```bash
# Override CMD
docker run nginx nginx -v

# Override ENTRYPOINT
docker run --entrypoint bash nginx
```

##### Via Docker Compose
```yaml
services:
  nginx:
    image: nginx
    command: nginx -v  # Overrides CMD
```

#### Best Practices
1. **Service-Specific**
   - Simple services: Use CMD alone
   - Complex services: Use ENTRYPOINT + CMD

2. **Initialization**
   - Keep setup scripts minimal
   - Handle signals properly
   - Use exec to replace shell with service

3. **Configuration**
   - Use environment variables
   - Avoid hardcoded values
   - Implement proper error handling

4. **Process Management**
   - Run service as PID 1 when possible
   - Avoid unnecessary wrapper scripts
   - Ensure proper signal handling






