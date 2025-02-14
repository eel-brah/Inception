FROM alpine:3.21.2  

RUN apk add --no-cache mariadb mariadb-client  # Install MariaDB and its client without caching package files

# Create MySQL runtime directory and set ownership
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

# Create data directory, set ownership and permissions
RUN mkdir -p /var/lib/mysql && \
    chown -R mysql:mysql /var/lib/mysql && \
    chmod 777 /var/lib/mysql

# Copy configuration file
COPY my.cnf /etc/my.cnf.d/mariadb-server.cnf

# Initialize the MySQL data directory
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Copy and make the entrypoint script executable
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

# Declare that /var/lib/mysql will be a mount point
VOLUME /var/lib/mysql

# Expose MySQL port
EXPOSE 3306

# Set the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]

# Default command 
CMD ["mariadbd", "--user=mysql"]
