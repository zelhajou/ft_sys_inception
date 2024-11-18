## MariaDB Initialization ScripT

### 1. Script Header

```bash
#!/bin/bash
set -e
```
- Using `/bin/bash` as the interpreter
- `set -e` flag stops the script on the first error
- Ensures that the script fails early if any command fails
- Prevents the script from continuing with an incomplete or incorrect setup

### 2. Initialization Check

```bash
if [ ! -d "/var/lib/mysql/mysql" ]; then
```
- `!` is the logical NOT operator
- `-d` checks if the directory exists
- `/var/lib/mysql/mysql` is the directory where MariaDB stores its system tables
- Why check for `/var/lib/mysql/mysql`:
    - This directory contains system tables
    - Its presence indicates a properly initialized database
    - More reliable than checking just `/var/lib/mysql`
    - Prevents re-initialization of existing databases
    - Important for data persistence across container restarts

### 3. Database Installation


```bash
mysql_install_db --user=mysql --datadir=/var/lib/mysql
```

- `mysql_install_db` is a script that initializes the MariaDB data directory
- `--user=mysql` specifies the user under which the MariaDB server will run
- `--datadir=/var/lib/mysql` specifies the data directory location
- This command initializes the MariaDB data directory with system tables and default databases


### 4. Bootstrap Configuration

```bash
mysqld --user=mysql --bootstrap << EOF
```

- `mysqld` is the MariaDB server daemon
- `--user=mysql` specifies the user under which the MariaDB server will run
- `--bootstrap` flag indicates that the server should run in bootstrap mode
- `<< EOF` starts a here document (a way to pass multiple lines of input to a command)
- The following lines are input to the `mysqld` command in bootstrap mode
- Why use bootstrap mode:
    - Allows running SQL commands without starting the server
    - Useful for initial configuration and setup
    - Avoids the need to start and stop the server for setup tasks

### 5. SQL Commands

```bash
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
```

- `FLUSH PRIVILEGES;` reloads the grant tables to ensur clean privileges state
- `ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';`
    - This line modifies the root user's password
    - `'root'@'localhost'`: Specifies the root user that can only connect from localhost
    - `IDENTIFIED BY`: Sets the authentication method
    - `$MYSQL_ROOT_PASSWORD`: Environment variable containing the new root password
    - This is done first for security reasons - securing the root account should be the first step

- `CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;`
    - Creates a new database if it doesn't already exist
    - `IF NOT EXISTS`: Prevents errors if the database already exists
    - `$MYSQL_DATABASE`: Environment variable containing the database name (wordpress in this case)
    - This is done second because we need the database to exist before we can grant permissions on it

- `CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';`
    - Creates a new database user
    - `'$MYSQL_USER'`: Environment variable for the username (wpuser in this case)
    - `'@'%'`: The `%` is a wildcard meaning "allow connections from any host"
        - This is different from `@'localhost'` which would only allow local connections
        - We use `%` because WordPress will connect from a different container
    - `IDENTIFIED BY '$MYSQL_PASSWORD'`: Sets the user's password
    - This is done third because we need the user to exist before granting them privileges
- `GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';`
    - Gives the new user full permissions on the database
    - `ALL PRIVILEGES`: Grants all possible permissions (SELECT, INSERT, UPDATE, DELETE, etc.)
    - `$MYSQL_DATABASE.*`: The `.*` wildcard means "all tables in this database"
        - The dot (.) separates database and table names
        - The asterisk (*) means "all tables"
    - `TO '$MYSQL_USER'@'%'`: The user and host to receive these privileges
    - This is done last because both the database and user must exist before granting privileges
- `FLUSH PRIVILEGES;` reloads the grant tables to apply the changes


6. Server Start

```bash
exec mysqld --user=mysql
```

- Why use exec:
    - Replaces shell process with MySQL
    - Makes MySQL PID 1 in container
    - Proper signal handling
    - Clean container shutdown
    - Follows Docker best practices
