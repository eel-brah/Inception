FROM alpine:3.20

RUN apk add --no-cache \
    php83 \
    php83-session \
    php83-mysqli \
    php83-pdo_mysql \
    curl

RUN mkdir -p /var/www/adminer && \
    curl -L -o /var/www/adminer/adminer.php https://www.adminer.org/latest.php

RUN chown -R nobody:nobody /var/www/adminer
USER nobody

EXPOSE 8080

ENTRYPOINT ["php83", "-S", "0.0.0.0:8080", "/var/www/adminer/adminer.php"]
