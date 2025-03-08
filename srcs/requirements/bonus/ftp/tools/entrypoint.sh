#!/bin/sh
set -e

if ! id -u "${FTP_USER}" >/dev/null 2>&1; then
  FTP_PASSWORD=$(cat /run/secrets/ftp_password)
  adduser -D -h "/home/${FTP_USER}" "${FTP_USER}"
  echo "${FTP_USER}:${FTP_PASSWORD}" | chpasswd

  cat <<EOF >> /etc/vsftpd/vsftpd.conf
local_root=/home/${FTP_USER}/wordpress_files
EOF

fi

chown $FTP_USER:$FTP_USER /home/${FTP_USER}/wordpress_files \
	&& chmod 774 /home/${FTP_USER}/wordpress_files 

exec vsftpd /etc/vsftpd/vsftpd.conf
