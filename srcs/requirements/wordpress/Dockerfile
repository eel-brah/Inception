FROM alpine:3.20

RUN apk add --no-cache \
    php83-fpm \
    php83-mysqli \
    php83-json \
    php83-openssl \
    php83-curl \
    php83-zlib \
    php83-xml \
    php83-phar \
    php83-intl \
    php83-dom \
    php83-xmlreader \
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
    tar -xzf latest.tar.gz && \
    mv wordpress/* . && \
    rm -rf wordpress latest.tar.gz

# Set proper ownership and permissions for the WordPress files
RUN chown -R nobody:nobody /var/www/html && \
    chmod -R 755 /var/www/html

COPY ./conf/wp-config.php /var/www/html/
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod 644 /var/www/html/wp-config.php && \
    chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
