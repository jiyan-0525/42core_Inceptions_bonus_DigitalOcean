<?php
define('DB_NAME', getenv('WORDPRESS_DB_NAME') ?: getenv('MYSQL_DATABASE'));
define('DB_USER', getenv('WORDPRESS_DB_USER') ?: getenv('MYSQL_USER'));
define('DB_PASSWORD', trim(file_get_contents('/run/secrets/db_password')));
define('DB_HOST', getenv('WORDPRESS_DB_HOST') ?: 'mariadb:3306');

define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

$table_prefix  = 'wp_';
define('WP_DEBUG', false);

$salts = @file_get_contents('https://api.wordpress.org/secret-key/1.1/salt/');
if ($salts) {
    echo $salts;
}

if ( !defined('ABSPATH') ) {
    define('ABSPATH', dirname(__FILE__) . '/');
}
require_once(ABSPATH . 'wp-settings.php');
