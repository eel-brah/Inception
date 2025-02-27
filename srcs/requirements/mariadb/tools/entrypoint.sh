#!/bin/sh
set -e

# Read secrets from files
MD_ROOT_PASSWORD=$(cat "$MD_ROOT_PASSWORD_FILE")
MD_WP_PASSWORD=$(cat "$MD_WP_PASSWORD_FILE")
MD_WP_USER=$(cat "$MD_WP_USER_FILE")

# Start MariaDB in background
mariadbd --user=mysql &
pid="$!"

# Wait for MySQL to start
until mysql -u root --password="$MD_ROOT_PASSWORD" -e "SELECT 1" >/dev/null 2>&1; do
    echo "Waiting for MySQL to start..."
    sleep 1
done

# Initialize database and users
mysql -u root --password="$MD_ROOT_PASSWORD" <<-EOSQL
    CREATE DATABASE IF NOT EXISTS $MD_DATABASE;
    DROP USER IF EXISTS '$MD_WP_USER'@'%';
    CREATE USER '$MD_WP_USER'@'%' IDENTIFIED BY '$MD_WP_PASSWORD';
    GRANT ALL PRIVILEGES ON $MD_DATABASE.* TO '$MD_WP_USER'@'%';

    FLUSH PRIVILEGES;
EOSQL

# Stop the temporary MariaDB instance
kill -s TERM "$pid"
wait "$pid"

# Start MariaDB in foreground
exec mariadbd --user=mysql
