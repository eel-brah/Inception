FROM alpine:3.20

RUN wget -qO /usr/bin/cadvisor https://github.com/google/cadvisor/releases/download/v0.49.2/cadvisor-v0.49.2-linux-amd64 \
    && chmod +x /usr/bin/cadvisor

EXPOSE 8080

CMD ["cadvisor", "-logtostderr", "-docker_only"]
