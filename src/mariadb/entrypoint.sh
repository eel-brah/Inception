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

# Create database if needed
if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
    mysql -u root --password="$MYSQL_ROOT_PASSWORD" <<-EOSQL
        CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
        CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
        GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
        FLUSH PRIVILEGES;
EOSQL
fi

# Stop the temporary MariaDB instance
kill -s TERM "$pid"
wait "$pid"


# Start MariaDB in foreground
exec mariadbd --user=mysql
