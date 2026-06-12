FROM debian:bookworm

# Install PHP-FPM and required extensions
RUN apt-get update && apt-get install -y \
  php8.2-fpm \
  php8.2-mysql \
  php8.2-curl \
  php8.2-gd \
  php8.2-intl \
  php8.2-mbstring \
  php8.2-soap \
  php8.2-xml \
  php8.2-zip \
  php8.2-redis \
  wget \
  curl \
  ca-certificates \
  netcat-openbsd \
  && ln -s /usr/sbin/php-fpm8.2 /usr/local/bin/php-fpm \
  && rm -rf /var/lib/apt/lists/*

# Create WordPress directory
WORKDIR /var/www/html

# Copy PHP-FPM configuration (correct version)
COPY tools/wp-setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wp-setup.sh
RUN mkdir -p /run/php

# Copy and set permissions for setup script
CRUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/wp-setup.sh"]
