#!/bin/sh
set -e

wait_for_db() {
    local max_retries=10
    local retry=0
    
    until php -r "
        \$conn = @mysqli_connect(
            getenv('WORDPRESS_DB_HOST'),
            getenv('WORDPRESS_DB_USER'),
            getenv('WORDPRESS_DB_PASSWORD'),
            getenv('WORDPRESS_DB_NAME'),
            getenv('WORDPRESS_DB_PORT') ?: 3306
        );
        exit(\$conn ? 0 : 1);
    " >/dev/null 2>&1 || [ $retry -eq $max_retries ]; do
        echo "Waiting for database connection... ($((retry+1))"
        sleep 10
        retry=$((retry+1))
    done
    
    [ $retry -lt $max_retries ] || return 1
}

# Set HTTP_HOST for CLI context
export HTTP_HOST="localhost"

install_wordpress() {
    wp core install \
        --url="https://localhost:4443" \
        --title="blog" \
        --admin_user="bob" \
        --admin_password="Bob@123456789" \
        --admin_email="bob@example.com" \
        --skip-email
}

create_user() {
    local email=$1
    local user=$2
    local pass=$3
    local role=$4
    
    if ! wp user get "$user" --field=id 2>/dev/null; then
        wp user create "$user" "$email" --role="$role" --user_pass="$pass"
    fi
}

# Main execution
if wait_for_db; then
    if ! wp core is-installed; then
        install_wordpress
        create_user jack@example.com jack jack administrator
        create_user sam@example.com sam sam subscriber
    fi
    exec php-fpm83 -F
else
    echo "Failed to connect to database after multiple attempts"
    exit 1
fi
