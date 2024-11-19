- **Key Components:**
	1. **Virtual Machine:** The entire project must be executed within a Virtual Machine (VM). This ensures that the environment is controlled and isolated from the host system.
	2. **Docker Containers:**
		- You will be creating multiple Docker containers, each dedicated to a specific service.
		- **Services Required:**
			- **NGINX** with TLSv1.2 or TLSv1.3
			- **WordPress** with php-fpm (without NGINX)
			- **MariaDB (a popular database system)**
		- Each service must have its Dockerfile, and the Docker images must be built by you using Docker Compose. It is forbidden to use pre-built images from sources like DockerHub (with the exception of Alpine or Debian as base images).
	3. **Volumes and Networking:**
		- You will set up Docker volumes to persist data, particularly for the WordPress database and website files.
		- A custom Docker network must be created to allow the containers to communicate with each other securely.
	4. **Domain Configuration:**
		- You must configure a domain name that points to your local IP address. This domain will be in the format `login.42.fr`, where "login" is your own username.
	5. **Security and Best Practices:**
		- Environment variables must be used for sensitive data such as passwords, which should be stored in a `.env` file.
		- The NGINX container should be the only entry point to your infrastructure, serving traffic over HTTPS via port 443.

- **Bonus Objectives:**
	- If you successfully complete the mandatory tasks perfectly, you can also add extra services as part of a bonus. These can include setting up:
		- A Redis cache for WordPress.
		- An FTP server.
		- A simple static website (excluding PHP).
		- Adminer, a database management tool.
		- Any other service you deem useful, provided you can justify its inclusion.