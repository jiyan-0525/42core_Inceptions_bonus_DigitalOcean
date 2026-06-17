FROM debian:bullseye

RUN apt-get update && apt-get install -y \
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
<<<<<<< HEAD
CMD ["php-fpm7.4", "-F"]
=======
CMD ["php-fpm7.4", "-F"]
>>>>>>> 8d6f6e3 (addbons)
