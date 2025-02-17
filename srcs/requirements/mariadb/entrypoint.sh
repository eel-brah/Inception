#!/bin/sh
set -e

# Start MariaDB in background
mariadbd --user=mysql &
pid="$!"

# Wait for MySQL to start
until mysql -u root --password="$MYSQL_ROOT_PASSWORD" -e "SELECT 1" >/dev/null 2>&1; do
    echo "Waiting for MySQL to start..."
    sleep 1
done

# Initialize database and users
mysql -u root --password="$MYSQL_ROOT_PASSWORD" <<-EOSQL
    CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
    DROP USER IF EXISTS '$MYSQL_USER'@'%';
    CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
    GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';

    FLUSH PRIVILEGES;
EOSQL

# Stop the temporary MariaDB instance
kill -s TERM "$pid"
wait "$pid"

# Start MariaDB in foreground
exec mariadbd --user=mysql
