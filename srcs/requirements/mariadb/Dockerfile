FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqld /var/log/mysql /var/lib/mysql && \
    chown -R mysql:mysql /var/run/mysqld /var/log/mysql /var/lib/mysql

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/db-setup.sh /db-setup.sh

RUN chmod +x /db-setup.sh && \
    chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE 3306

ENTRYPOINT ["/db-setup.sh"]
