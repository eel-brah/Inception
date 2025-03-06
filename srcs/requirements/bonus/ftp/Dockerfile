FROM alpine:3.20

RUN apk add --no-cache vsftpd 

EXPOSE 21 21100-21110

COPY ./conf/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY ./tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
