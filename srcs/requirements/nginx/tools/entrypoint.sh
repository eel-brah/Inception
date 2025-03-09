#!/bin/sh

envsubst '${DOMAIN} ${DOMAIN2}' < /etc/nginx/conf.d/ssl.conf.template > /etc/nginx/conf.d/ssl.conf

exec nginx -g "daemon off;"
