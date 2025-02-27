<?php
/**
 * The base configuration for WordPress
 */

// Database settings
define('DB_NAME', 'wordpress_db');
define( 'DB_USER', trim(file_get_contents('/run/secrets/db_user')) );
define( 'DB_PASSWORD', trim(file_get_contents('/run/secrets/db_user_password')) );
define('DB_HOST', 'mariadb');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

define('AUTH_KEY',         'utg<-mkPOk6RA0$RuYv;%)9s?L#=LWN#fAY (R;P6#5s}v8^H13Jp&!~7`6!jh($');
define('SECURE_AUTH_KEY',  '|0A G/<#7|*+-8]iNhtynxY:67!wlmNzb%}W=orkJ$qV}ch2HqU*JJ?|<B?%#cAL');
define('LOGGED_IN_KEY',    'UQo-(Cgs[?@bF-E|+hCk6F6A*nkHe!e4DM>6ZF6FO61cY^34EZh-;@aYilubgltI');
define('NONCE_KEY',        'G-A};Nx){d1m5v7AiRtb1.{d_fG:tfCAW>j&!b*+WugaljB8UvRE{8U?7~>poA8D');
define('AUTH_SALT',        'F?OLpUyT<Z1yi{+x*.8*}+VE=Z4xYA6Y#482f?hf<TF<I1FQo.>zX*;Fl%BPd^| ');
define('SECURE_AUTH_SALT', 'W0Nic{kH[Szek,%/|MUvvL @v)N5)Rk]7KB/A^h+$0C?}p@A]IL0*s77hB!,;)rm');
define('LOGGED_IN_SALT',   'g=mw3iU&$4#I^k% oNcFR{#^p6@;A+gO8aREHIj$Z}ZRp._6HEu3d+6)xTD c/Q`');
define('NONCE_SALT',       'gH=q?0kc{/ozODYn{M  |-NYF&l91ee~:GTxFFZtN{<w_Ste*R8L+I.n+|$I(v-i');

// define('AUTH_KEY',         trim(file_get_contents('/run/secrets/auth_key')));
// define('SECURE_AUTH_KEY',  trim(file_get_contents('/run/secrets/secure_auth_key')));
// define('LOGGED_IN_KEY',    trim(file_get_contents('/run/secrets/logged_in_key')));
// define('NONCE_KEY',        trim(file_get_contents('/run/secrets/nonce_key')));
// define('AUTH_SALT',        trim(file_get_contents('/run/secrets/auth_salt')));
// define('SECURE_AUTH_SALT', trim(file_get_contents('/run/secrets/secure_auth_salt')));
// define('LOGGED_IN_SALT',   trim(file_get_contents('/run/secrets/logged_in_salt')));
// define('NONCE_SALT',       trim(file_get_contents('/run/secrets/nonce_salt')));

$table_prefix = 'wp_';

define( 'WP_DEBUG', true );

if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}

require_once ABSPATH . 'wp-settings.php';
