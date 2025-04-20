<?php
/**
 * The base configuration for WordPress
 */

// Database settings
define('DB_NAME', getenv('WORDPRESS_DB_NAME')?: 'wordpress_db');
define( 'DB_USER', trim(file_get_contents('/run/secrets/db_user')) );
define( 'DB_PASSWORD', trim(file_get_contents('/run/secrets/db_user_password')) );
define('DB_HOST', getenv('WORDPRESS_DB_HOST') ?: 'mariadb');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

define('WP_REDIS_HOST', 'redis');
define('WP_REDIS_PORT', 6379);
define('WP_REDIS_DATABASE', 0);
define('WP_CACHE', true);
define('WP_REDIS_READ_TIMEOUT', 1);

// Load WordPress salts from the generated file
$salt_file = '/run/secrets/wp_salts';
if (file_exists($salt_file)) {
    foreach (file($salt_file, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES) as $line) {
        if (preg_match("/define\('(.*)',\s*'(.*)'\);/", $line, $matches)) {
            define($matches[1], $matches[2]);
        }
    }
}

if (!isset($_SERVER['HTTP_HOST'])) {
    $_SERVER['HTTP_HOST'] = getenv('WORDPRESS_SITE_HOST') ?: 'localhost';
}

$table_prefix = 'wp_';

define( 'WP_DEBUG', false );

if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}

require_once ABSPATH . 'wp-settings.php';
