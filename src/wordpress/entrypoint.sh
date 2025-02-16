#!/bin/sh

# Wait for database to be ready
wait_for_db() {
    while ! php -r "
        \$conn = mysqli_connect(
            getenv('WORDPRESS_DB_HOST'),
            getenv('WORDPRESS_DB_USER'),
            getenv('WORDPRESS_DB_PASSWORD'),
            getenv('WORDPRESS_DB_NAME')
        );
        if (!\$conn) exit(1);
        exit(0);
    " > /dev/null 2>&1; do
        sleep 5
    done
}

# Wait for database
wait_for_db

# Then run the setup-users script
/usr/local/bin/setup-users.sh &

# Start PHP-FPM in the foreground
exec php-fpm83 -F
