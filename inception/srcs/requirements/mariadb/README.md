# MariaDB Dockerfile

```dockerfile
FROM alpine:3.19
```

- This is the base image for my container.
- I use Alpine 3.19 specifically (not 'latest') as per the project requirements.
- Alpine is chosen because:
    - It has an extremely small size (around 5MB, compared to Debian's ~120MB).
    - It is security-focused, offering a smaller attack surface.
    - It has official support for MariaDB.
    - Version 3.19 is the penultimate stable version, as required by the project.

```dockerfile
RUN apk update && apk add --no-cache \
    mariadb \
    mariadb-client \
    mariadb-common \
    bash \
    gettext
```

- This command installs the required packages for MariaDB.
    - `apk update`: Updates the package index
    - `--no-cache`: Prevents storing the package cache, reducing image size
- Packages installed:

    - `mariadb`: The main database server
    - `mariadb-client`: Command-line tools to interact with MariaDB
    - `mariadb-common`: Common files needed by both server and client
    - `bash`: Required for our entrypoint script (Alpine uses ash by default)
    - `gettext`: Provides `envsubst` for environment variable substitution in SQL files

```dockerfile
&& mkdir -p /run/mysqld \
    && chown -R mysql:mysql /run/mysqld \
    && mkdir -p /var/lib/mysql \
    && chown -R mysql:mysql /var/lib/mysql
```

- These commands create the necessary directories for MariaDB and set the correct ownership.
    - `/run/mysqld`: Directory for MariaDB's socket and PID files.
    - `/var/lib/mysql`: Directory for MariaDB's data files.

- setting the correct ownership is important for MariaDB to function correctly.
    - `mysql:mysql` is the user and group that MariaDB runs as.
    - `chown -R` recursively changes the ownership of the directories.

- This is in the same RUN command as package installation to reduce layers


```dockerfile
COPY conf/my.cnf /etc/my.cnf.d/mariadb-server.cnf
```

- This command copies the custom MariaDB configuration file to the container.
- Placed in `/etc/my.cnf.d/` which is where Alpine looks for MariaDB configs.
- The file is named `mariadb-server.cnf` to avoid conflicts with other configurations.

```dockerfile
COPY tools/sql/ /docker-entrypoint-initdb.d/
```

- This command copies the SQL files to be executed on container startup.
- Placed in `/docker-entrypoint-initdb.d/` which is where MariaDB looks for initialization scripts.
- Files will be executed in alphabetical order (hence our numeric prefixes).

```dockerfile
COPY tools/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
```
- This command copies the entrypoint script to the container.
- Placed in `/usr/local/bin/` which is in the PATH. so we can call it directly
- The script is made executable with `chmod +x`.

```dockerfile
RUN mkdir -p /var/run/mysqld \
    && chown -R mysql:mysql /var/run/mysqld \
    && chmod 777 /var/run/mysqld
```
- This command creates the directory for MariaDB's socket file.
- The socket file is used for local connections to the database.
 - `chmod 777` allows all users to read/write/execute the directory.
    - This is needed because MariaDB needs to create its socket file here

```dockerfile
EXPOSE 3306
```

- Documents that the container will listen on port 3306
- This is MariaDB's default port
- This is documentation only - actual port publishing happens in docker-compose.yml

```dockerfile
ENTRYPOINT ["docker-entrypoint.sh"]
```

- Sets the entrypoint script that will run when container starts