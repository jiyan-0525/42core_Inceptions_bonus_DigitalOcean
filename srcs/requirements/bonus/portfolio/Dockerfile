FROM debian:bullseye

RUN echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until && \
    sed -i 's|deb.debian.org|archive.debian.org|g; s|security.debian.org|archive.debian.org|g' /etc/apt/sources.list && \
    apt-get update && apt-get install -y python3 && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

COPY html/ /var/www/html/

EXPOSE 8081

CMD ["python3", "-m", "http.server", "8081"]
