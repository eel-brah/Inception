FROM alpine:3.20

RUN apk add --no-cache \
    php83 \
    php83-session \
    php83-mysqli \
    php83-pdo_mysql \
    curl

RUN mkdir -p /var/www/html && \
    curl -L -o /var/www/html/adminer.php https://www.adminer.org/latest.php

WORKDIR /var/www/html

EXPOSE 8080

ENTRYPOINT ["php83", "-S", "0.0.0.0:8080", "/var/www/html/adminer.php"]
