#!/bin/sh
set -e

# Read secrets from files
export WORDPRESS_DB_PASSWORD=$(cat "$WORDPRESS_DB_PASSWORD_FILE")
export WORDPRESS_DB_USER=$(cat "$WORDPRESS_DB_USER_FILE")
export WP_ADMIN_PASSWORD=$(cat "$WORDPRESS_ADMIN_PASSWORD_FILE")

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
export HTTP_HOST=${WORDPRESS_SITE_HOST}

install_wordpress() {
    wp core install \
        --url="${WORDPRESS_SITE_URL}" \
        --title="${WORDPRESS_SITE_TITLE}" \
        --admin_user="${WORDPRESS_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WORDPRESS_ADMIN_EMAIL}" \
        --skip-email
}
echo $WP_ADMIN_PASSWORD > /run/filett

create_user() {
    local email=$1
    local user=$2
    local role=$3
    
    if ! wp user get "$user" --field=id 2>/dev/null; then
        pass=$(cat "/run/secrets/wp_user_${user}_password")
        wp user create "$user" "$email" --role="$role" --user_pass="$pass"
    fi
}

# Main execution
if wait_for_db; then
    if ! wp core is-installed; then
        install_wordpress
        create_user "${WP_USER1_EMAIL}" \
                   "${WP_USER1_NAME}" \
                   "${WP_USER1_ROLE}"
    fi
    exec php-fpm83 -F
else
    echo "Failed to connect to database after multiple attempts"
    exit 1
fi
