### 1. **Docker Concepts (Covered)**
   - **Containers, Images, Dockerfiles**: You should now have a solid understanding of containers, how to create Docker images using Dockerfiles, and how to manage containers with Docker.
   - **Docker Compose**: You’ll need to use Docker Compose to orchestrate multiple containers (NGINX, WordPress, MariaDB, etc.).
   - **Volumes and Networking**: Persistent storage (volumes) and networking between containers are critical parts of this project.

### 2. **Virtual Machine Setup (Covered Briefly)**
   - You must run everything inside a virtual machine (VM). Setting up a VM and running Docker inside it is crucial. This ensures isolation from your host environment, simulating a production-like scenario.

### 3. **System Administration Knowledge**
   - **Linux/Unix Fundamentals**: Basic knowledge of Linux commands, file permissions, and process management is essential since the project will run inside a Linux-based VM.
   - **Package Management**: Familiarity with package managers like `apt` or `yum` to install necessary tools within your VM.

### 4. **Web Server Configuration (NGINX)**
   - **TLS Configuration**: You need to configure NGINX with TLSv1.2 or TLSv1.3 to ensure encrypted communication. Understanding SSL/TLS certificates, how to generate and manage them, and how to configure NGINX to use them is necessary.
   - **Reverse Proxy**: NGINX will act as the reverse proxy, directing traffic to your WordPress container. You need to know how to configure this correctly in your NGINX configuration files.

### 5. **Database Configuration (MariaDB)**
   - **SQL Basics**: You need to create users, manage databases, and understand basic SQL commands to configure the MariaDB container correctly.
   - **Database Security**: Ensuring secure connections between your WordPress container and the MariaDB container, setting up user permissions, and managing environment variables securely.

### 6. **WordPress Setup**
   - **PHP and WordPress Configuration**: You will need to configure WordPress to connect to your MariaDB container. This involves understanding how WordPress uses `wp-config.php` to manage database connections and other settings.
   - **WordPress Admin and User Management**: You need to create and manage WordPress users securely, ensuring that the administrator’s username meets the project's specific requirements.

### 7. **Security Best Practices**
   - **Environment Variables and .env File**: Ensure that sensitive information like database passwords and API keys are stored securely using environment variables in a `.env` file. This file should be included in your Docker Compose configuration and kept out of version control (e.g., using `.gitignore`).
   - **General Security**: Docker best practices suggest running containers with minimal privileges, avoiding hardcoding credentials in Dockerfiles, and regularly updating your Docker images.

### 8. **Makefile for Automation**
   - You need to write a Makefile to automate the entire build process. The Makefile should handle building Docker images, starting containers with Docker Compose, and setting up the environment.

### 9. **Custom Domain and Local DNS Setup**
   - **Domain Configuration**: You'll need to configure your local DNS to map a custom domain (e.g., `yourlogin.42.fr`) to your local IP address. This will involve editing your `/etc/hosts` file or using a local DNS server to resolve the domain name.

### 10. **Understanding the Project Rules**
   - **Restrictions**: The project has specific rules, such as not using pre-built Docker images (other than Alpine/Debian), not using certain network configurations like `network: host` or `--link`, and not running containers with commands that create infinite loops (e.g., `tail -f`, `sleep infinity`).
   - **Restart Policies**: Ensure that containers restart automatically in case of a crash, which can be configured in your Docker Compose file.

### 11. **Bonus Section (Optional)**
   - If you complete the mandatory tasks perfectly, you can explore bonus tasks, such as setting up Redis cache for WordPress, creating a static website, or adding an FTP server. These bonuses require additional knowledge of the respective technologies.

### Summary

While the Docker concepts provided earlier cover a significant portion of what you need, you also need to focus on:

- **Linux/Unix skills** for working inside a VM.
- **Web server configuration** with NGINX, particularly around TLS and reverse proxying.
- **Database setup and security** with MariaDB.
- **Custom domain configuration** for local DNS resolution.
- **Writing a Makefile** to automate the entire process.
