## MariaDB Dockerfile

```dockerfile
FROM alpine:3.19
```
- I chose the alpine image because it is a lightweight image and has a small size compared to other images 
- Using the penultimate stable version as required by the subject
- The official MariaDB image is not used because it is not allowed by the subject


```dockerfile
RUN apk update && apk add --no-cache \
    mariadb \
    mariadb-client \
    mariadb-common \
    bash
```
- `apk update` Updates the package index
- `--no-cache` Doesn't store the package cache, reducing image size

- Packages installed:

    - `mariadb`: The core database server
    - `mariadb-client`: Command-line tools to interact with MariaDB
    - `mariadb-common`: Common files needed by server and client
    - `bash`: Required for our entrypoint script (Alpine uses ash by default)

```dockerfile
RUN mkdir -p /run/mysqld && \
    mkdir -p /var/log/mysql && \
    chown -R mysql:mysql /run/mysqld && \
    chown -R mysql:mysql /var/log/mysql
```
1. `mkdir -p /run/mysqld`:

    - Creates the directory `/run/mysqld` where MariaDB stores its process ID (PID) file
    - The `-p` flag creates parent directories if they don't exist
    - This directory is needed for the MySQL socket file which allows local connections

    ```md
    - This directory is absolutely necessary because it's where MariaDB stores its Unix socket file (mysqld.sock)
    - The socket file is used for local communications between MariaDB server and client programs
    - Without this directory, MariaDB can't create its socket file and local connections would fail
    ```

2. `mkdir -p /var/log/mysql`:

    - Creates the directory for MariaDB log files
    - Will contain error logs, slow query logs, etc.
    - Important for debugging and monitoring database operations

    ```md
    - This directory is needed for MariaDB's logging system to store:
        - Error logs (mysql-error.log)
        - Slow query logs
        - General query logs
        - Binary logs for replication
    - Without this, MariaDB couldn't write logs, making debugging almost impossible
    ```

4. `chown -R mysql:mysql /run/mysqld`:

    - Changes the ownership of /run/mysqld directory to mysql user and group
    - -R flag makes it recursive (applies to all subdirectories)
    - This is necessary because MariaDB runs as the mysql user for security

    ```md
    - MariaDB runs as the 'mysql' user for security
    - The mysql user must own this directory to:
        - Create the socket file
        - Write to the socket file
        - Allow other processes to communicate with MariaDB
    - Without this ownership, MariaDB would fail to create/access its socket file
    ```

5. `chown -R mysql:mysql /var/log/mysql`:

    - Changes ownership of log directory to mysql user and group
    - Allows MariaDB to write log files

    ```md
    - The mysql user must own the log directory to:
        - Create log files
        - Write to log files
        - Rotate logs when they get too large
    - Without this ownership, MariaDB couldn't write logs
    ```

The command is combined using `&&` operators, which means:

- Commands are executed sequentially
- If any command fails, the subsequent commands won't execute
- The RUN instruction will fail if any command in the chain fails


```dockerfile
COPY conf/my.cnf /etc/my.cnf.d/mariadb-server.cnf
```

- This copies your custom MariaDB configuration file into the container
- The file contains important settings like:
    - Network configuration
    - Character set settings
    - Buffer sizes
    - Performance parameters
- Without this, MariaDB would use default settings which might not be optimal

- `my.cnf` is the MariaDB configuration file
    ```cnf
    [mysqld]
    user                   = mysql
    pid-file               = /run/mysqld/mariadb.pid
    socket                 = /run/mysqld/mysqld.sock
    port                   = 3306
    datadir                = /var/lib/mysql
    log-error              = /var/log/mysql/error.log
    ```
    - Basic server configuration:
        - Runs as mysql user
        - PID file location for process management
        - Unix socket location for local connections
        - Standard port 3306
        - Data directory location
        - Error log location
    ```cnf
    bind-address          = 0.0.0.0
    skip-networking       = false
    ```
    - Network configuration:
        - Allows connections from any IP address
        - Required since WordPress container needs to connect to MariaDB
        - Enables networking support

```dockerfile
COPY tools/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
```

- `COPY tools/docker-entrypoint.sh /usr/local/bin/`:
    - Copies your initialization script to the container
    - The script handles:
        - Database initialization
        - User creation
        - Setting up permissions
        - Initial database configuration
    - Without this script, MariaDB would start with default settings and no databases
    - details explanation of the script is in the [tools/README.md](./tools/README.md)

- `RUN chmod +x /usr/local/bin/docker-entrypoint.sh`:
    - Changes the script's permissions to make it executable
    - Necessary to run the script as an entrypoint

```dockerfile
EXPOSE 3306
```

- `EXPOSE 3306`:
    - Exposes the MariaDB port 3306 to the host machine
    - Required for other containers to connect to MariaDB
    - Without this, other containers can't access MariaDB

```dockerfile
ENTRYPOINT ["docker-entrypoint.sh"]
```

- `ENTRYPOINT ["docker-entrypoint.sh"]`:
    - Sets the entrypoint script to run when the container starts
    - The script initializes the database and starts the MariaDB server
    - Without this, the container would start with default settings and no databases
