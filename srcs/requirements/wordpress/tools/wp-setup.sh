#!/bin/bash
set -e

WP_PATH="/var/www/html"

# Load DB password
if [ ! -f /run/secrets/db_password ]; then
    echo "ERROR: /run/secrets/db_password not found!"
    exit 1
fi
DB_PASSWORD=$(cat /run/secrets/db_password)

# Wait for MariaDB
echo "Waiting for MariaDB..."
while ! nc -z "$WORDPRESS_DB_HOST" 3306; do sleep 2; done

# Install WP-CLI
if [ ! -f /usr/local/bin/wp ]; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

# Install WordPress
if [ ! -f "$WP_PATH/wp-config.php" ]; then
    wget -q https://wordpress.org/latest.tar.gz -O /tmp/wp.tar.gz
    tar -xzf /tmp/wp.tar.gz -C /tmp
    cp -rn /tmp/wordpress/* "$WP_PATH"
    
    WP_SALTS=$(wget -qO- https://api.wordpress.org/secret-key/1.1/salt/)
    
    # Everything for wp-config.php must be INSIDE the heredoc
    cat > "$WP_PATH/wp-config.php" <<EOF
<?php
define('DB_NAME', '${MYSQL_DATABASE}');
define('DB_USER', '${MYSQL_USER}');
define('DB_PASSWORD', '${DB_PASSWORD}');
define('DB_HOST', '${WORDPRESS_DB_HOST}');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');
\$table_prefix = 'wp_';
${WP_SALTS}
define('WP_REDIS_HOST', 'redis');
define('WP_REDIS_PORT', 6379);

define('WP_DEBUG', false);
if (!defined('ABSPATH')) define('ABSPATH', __DIR__ . '/');
require_once ABSPATH . 'wp-settings.php';
EOF

     wp core install \
    --url="https://${DOMAIN_NAME}" \
    --title="${WP_TITLE}" \
    --admin_user="${WP_ADMIN}" \
    --admin_password="${WP_ADMIN_PASSWORD}" \
    --admin_email="${WP_ADMIN_EMAIL}" \
    --allow-root \
    --path="$WP_PATH"

   wp plugin install redis-cache --activate --allow-root --path="$WP_PATH"
   wp redis enable --allow-root --path="$WP_PATH"

  wp user create \
    "${WP_USER}" \
    "${WP_USER_EMAIL}" \
    --role=subscriber \
    --user_pass="${WP_USER_PASSWORD}" \
    --allow-root \
    --path="$WP_PATH"
fi
    chown -R www-data:www-data "$WP_PATH"

echo "Starting PHP-FPM..."
exec php-fpm8.2 -F -R