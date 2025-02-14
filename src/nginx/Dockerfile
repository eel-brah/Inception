FROM alpine:3.21.2

RUN apk add nginx openssl

# Create a directory to store SSL certificates
RUN mkdir -p /etc/nginx/ssl

# Generate a self-signed SSL certificate using openssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=US/ST=State/L=City/O=Organization/CN=localhost"

RUN mkdir -p /run/nginx

COPY nginx.conf /etc/nginx/

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
