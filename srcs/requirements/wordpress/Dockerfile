FROM alpine:3.20

RUN apk add --no-cache \
    php83-fpm \
    php83-mysqli \
    php83-json \
    php83-openssl \
    php83-curl \
    php83-xml \
    php83-phar \
    php83-intl \
    php83-dom \
    php83-ctype \
    php83-session \
    php83-mbstring \
    php83-gd \
    curl

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Configure PHP-FPM
COPY ./conf/www.conf /etc/php83/php-fpm.d/www.conf

# Download the latest WordPress release
WORKDIR /var/www/html
RUN curl -O https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz --strip-components=1 && \
    rm latest.tar.gz

COPY ./conf/wp-config.php /var/www/html/
COPY tools/entrypoint.sh /

# Set proper ownership and permissions 
RUN chmod 644 /var/www/html/wp-config.php && \
    chmod +x /entrypoint.sh && \
    chown -R nobody:nobody /var/www/html

EXPOSE 9000

ENTRYPOINT ["/entrypoint.sh"]
