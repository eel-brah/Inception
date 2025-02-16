#!/bin/sh

# Check if WordPress is installed
wp_check() {
    wp core is-installed --allow-root > /dev/null 2>&1
    return $?
}

# Keep trying until WordPress is installed
until wp_check; do
    echo "Waiting for WordPress to be fully installed..."
    sleep 10
done

# Create users
wp user create jack jack@example.com --role=administrator --user_pass=jack --allow-root

wp user create sam sam@example.com --role=subscriber --user_pass=sam --allow-root
