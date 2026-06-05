FROM debian:bookworm 

RUN apt-get update && apt-get install -y \
    mariadb-server \
        && rm -rf /var/lib/apt/lists/*

        # Ensure the runtime directories exist and have correct permissions
RUN mkdir -p /var/run/mysqld && \
chown -R mysql:mysql /var/run/mysqld

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/db-setup.sh /db-setup.sh

RUN chmod +x /db-setup.sh
RUN chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE 3306

ENTRYPOINT ["/db-setup.sh"]