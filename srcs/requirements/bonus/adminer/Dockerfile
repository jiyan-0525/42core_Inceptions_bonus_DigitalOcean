FROM debian:bullseye

RUN echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until && \
    sed -i 's|deb.debian.org|archive.debian.org|g; s|security.debian.org|archive.debian.org|g' /etc/apt/sources.list && \
    apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Create directory for Adminer
WORKDIR /var/www/html

# Download Adminer single PHP file
RUN wget "https://www.adminer.org/latest.php" -O index.php

# PHP-FPM configuration for Adminer
RUN mkdir -p /run/php && chmod 755 /run/php
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Expose PHP-FPM port
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm7.4", "-F"]
