FROM alpine:3.20

RUN apk add --no-cache nginx envsubst

COPY conf /etc/nginx/
COPY tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 443

ENTRYPOINT ["/entrypoint.sh"]
