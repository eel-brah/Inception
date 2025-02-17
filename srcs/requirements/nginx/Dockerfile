FROM alpine:3.20

RUN apk add --no-cache nginx

COPY ssl /etc/nginx/ssl
COPY conf /etc/nginx/

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]
