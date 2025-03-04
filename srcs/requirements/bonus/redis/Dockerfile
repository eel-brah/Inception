FROM alpine:3.20

RUN apk add --no-cache redis

EXPOSE 6379

ENTRYPOINT ["redis-server", "--protected-mode", "no", "--maxmemory", "256mb", "--maxmemory-policy", "allkeys-lru"]
