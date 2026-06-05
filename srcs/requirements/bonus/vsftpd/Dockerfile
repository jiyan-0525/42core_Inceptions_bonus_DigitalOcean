FROM debian:bullseye

RUN apt-get update && apt-get install -y vsftpd && rm -rf /var/lib/apt/lists/*

COPY conf/vsftpd.conf /etc/vsftpd.conf
COPY tools/ftp-setup.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/ftp-setup.sh

EXPOSE 21 21100-21110

ENTRYPOINT ["/usr/local/bin/ftp-setup.sh"]
