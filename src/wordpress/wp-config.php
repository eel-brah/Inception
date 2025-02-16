<?php
/**
 * The base configuration for WordPress
 */

define( 'DB_NAME', 'wordpress_db' );
define( 'DB_USER', 'wordpress_user' );
define( 'DB_PASSWORD', 'secure_password' );
define( 'DB_HOST', 'mariadb' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );

define('AUTH_KEY',         'unique phrase');
define('SECURE_AUTH_KEY',  'unique phrase');
define('LOGGED_IN_KEY',    'unique phrase');
define('NONCE_KEY',        'unique phrase');
define('AUTH_SALT',        'unique phrase');
define('SECURE_AUTH_SALT', 'unique phrase');
define('LOGGED_IN_SALT',   'unique phrase');
define('NONCE_SALT',       'unique phrase');

$table_prefix = 'wp_';

define( 'WP_DEBUG', true );

if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}

require_once ABSPATH . 'wp-settings.php';
