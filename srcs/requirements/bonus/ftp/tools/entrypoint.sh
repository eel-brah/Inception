#!/bin/sh
set -e

if ! id -u ftpuser >/dev/null 2>&1; then
    FTP_PASSWORD=$(cat /run/secrets/ftp_password)
    adduser -D -h /home/${FTP_USER} ${FTP_USER}
    echo "${FTP_USER}:${FTP_PASSWORD}" | chpasswd
fi

chown $FTP_USER:$FTP_USER /data/wordpress_files/ \
	&& chmod 774 /data/wordpress_files/ 

exec vsftpd /etc/vsftpd/vsftpd.conf
