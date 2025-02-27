#!/bin/bash

DIR="."
SSL_DIR="$DIR/secrets/ssl"
SSL_KEY="$SSL_DIR/nginx.key"
SSL_CRT="$SSL_DIR/nginx.crt"

mkdir -p "$SSL_DIR"

# [ ! -f "$DIR/secrets/wp_admin_password.txt" ] && openssl rand -base64 32 > "$DIR/secrets/wp_admin_password.txt"
# [ ! -f "$DIR/secrets/wp_user_jack_password.txt" ] && openssl rand -base64 32 > "$DIR/secrets/wp_user_jack_password.txt"
# # [ ! -f "$DIR/secrets/wp_db_password.txt" ] && openssl rand -base64 32 > "$DIR/secrets/wp_db_password.txt"
# [ ! -f "$DIR/secrets/db_root_password.txt" ] && openssl rand -base64 32 > "$DIR/secrets/db_root_password.txt"
# [ ! -f "$DIR/secrets/db_user_password.txt" ] && openssl rand -base64 32 > "$DIR/secrets/db_user_password.txt"
# [ ! -f "$DIR/secrets/db_user.txt" ] && echo wordpress_user > "$DIR/secrets/db_user.txt"
#
if [ ! -f "$SSL_KEY" ] || [ ! -f "$SSL_CRT" ]; then
    echo "Generating SSL certificates..."
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout "$SSL_KEY" \
        -out "$SSL_CRT" \
        -subj "/C=MA/ST=State/L=City/O=Org/CN=localhost"
    chmod 600 "$SSL_KEY" "$SSL_CRT"
fi
