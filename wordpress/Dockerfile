FROM alpine:3.21.2

RUN apk add --no-cache \
    php83 \
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

# Copy a custom PHP-FPM configuration file 
COPY www.conf /etc/php83/php-fpm.d/www.conf

WORKDIR /var/www/html

# Download the latest WordPress release, extract it, and clean up
RUN curl -O https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    mv wordpress/* . && \
    rm -rf wordpress latest.tar.gz


# Set proper ownership and permissions for the WordPress files
RUN chown -R nobody:nobody /var/www/html && \
    chmod -R 755 /var/www/html

# Copy a pre-configured wp-config.php file into the WordPress directory
# COPY ./wp-config.php /var/www/html

EXPOSE 9000

CMD ["php-fpm83", "-F"]
