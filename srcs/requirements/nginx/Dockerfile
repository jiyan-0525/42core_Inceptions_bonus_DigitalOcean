FROM debian:bullseye

RUN echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until && \
    sed -i 's|deb.debian.org|archive.debian.org|g; s|security.debian.org|archive.debian.org|g' /etc/apt/sources.list && \
    apt-get update && apt-get install -y nginx openssl && rm -rf /var/lib/apt/lists/*

# 创建存放 SSL 证书的目录
RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/C=DE/ST=BW/L=Heilbronn/O=42/OU=42Heilbronn/CN=jiyan.42.fr"

COPY conf/nginx.conf /etc/nginx/sites-available/default

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]