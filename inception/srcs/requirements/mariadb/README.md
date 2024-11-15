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
RUN mkdir -p /run/mysqld \
    && mkdir -p /var/lib/mysql \
    && mkdir -p /var/log/mysql \
    && chown -R mysql:mysql /run/mysqld \
    && chown -R mysql:mysql /var/lib/mysql \
    && chown -R mysql:mysql /var/log/mysql \
    && chmod 777 /var/log/mysql
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

2. `mkdir -p /var/lib/mysql`: 

    - Creates the directory where MariaDB stores all database files
    - This is the main data directory where actual database content is stored
    - Contains subdirectories for each database, table files, etc.

    ```md
    - This is the main data directory where MariaDB stores:
        - All database files
        - InnoDB tablespace files
        - Database table definitions
        - Actual table data
        - Index files
    - Without this directory, MariaDB would have nowhere to store your databases and would fail to start
    ```

3. `mkdir -p /var/log/mysql`:

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

5. `chown -R mysql:mysql /var/lib/mysql`:

    - Changes ownership of the data directory to mysql user and group
    - Ensures MariaDB has proper permissions to read/write database files
    - Critical for security and proper operation

    ```md
    - The mysql user must own the data directory to:
        - Create database files
        - Read database files
        - Write to database files
        - Create and modify tables
    - Without this ownership, MariaDB would fail to access or modify any data
    ```

6. `chown -R mysql:mysql /var/log/mysql`:

    - Changes ownership of log directory to mysql user and group
    - Allows MariaDB to write log files

    ```md
    - The mysql user must own the log directory to:
        - Create log files
        - Write to log files
        - Rotate logs when they get too large
    - Without this ownership, MariaDB couldn't write logs
    ```

7. `chmod 777 /var/log/mysql`:

    - Sets full read/write/execute permissions (777) on the log directory
    - Breakdown of 777:
        - First 7: Owner (mysql user) gets read(4) + write(2) + execute(1)
        - Second 7: Group (mysql group) gets read(4) + write(2) + execute(1)
        - Third 7: Others get read(4) + write(2) + execute(1)
    - Note: While 777 permissions are generally not recommended for security reasons (anyone can read/write/execute), it's necessary here because:
        - This is inside a container, which provides isolation
        - The container only runs MariaDB processes
        - The mysql user is the primary user of these directories
        - The container's isolation means external access is limited
    
    ```md
    - Sets permissions so that:
        - MariaDB can write logs (write permission)
        - Monitoring tools can read logs (read permission)
        - System processes can traverse the directory (execute permission)
    - Without these permissions, log writing could fail or monitoring tools might not be able to access logs
    ```

The command is combined using `&&` operators, which means:

- Commands are executed sequentially
- If any command fails, the subsequent commands won't execute
- The RUN instruction will fail if any command in the chain fails


Each of these steps is crucial for different aspects of MariaDB's operation:
- Socket creation (communication)
- Data storage (functionality)
- Logging (monitoring/debugging)
- Security (proper permissions)

If any of these directories is missing or has incorrect permissions, MariaDB would either:

- Fail to start completely
- Start but with limited functionality
- Start but be unable to write logs
- Start but be unable to create/modify databases

```dockerfile
COPY conf/my.cnf /etc/my.cnf.d/mariadb-server.cnf
```
- Copies the custom MariaDB configuration file to the container
- The file is copied to `/etc/my.cnf.d/mariadb-server.cnf` inside the container
- This file is used to configure MariaDB server settings