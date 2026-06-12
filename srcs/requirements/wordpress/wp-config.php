<?php
define('DB_NAME', '${MYSQL_DATABASE}');
define('DB_USER', '${MYSQL_USER}');
define('DB_PASSWORD', '${DB_PASSWORD}');
define('DB_HOST', 'mariadb:3306');

define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

\$table_prefix = 'wp_';
define('WP_DEBUG', false);

define('AUTH_KEY',         '2^vYE2>^=^X<-+jv8FO.4fR@eQ.\`P)Z5hF+PRez.^V @G9t.i;#ic\`B 8tT2iP3\`');
define('SECURE_AUTH_KEY',  '[-G(s@u85L@\$;-4L-2Lu@I5oB9J|%\`?lX,#HGX\$jg-*p5AT2eQ| Bn:3ZS4k4Tc:');
define('LOGGED_IN_KEY',    'K6{sLkD]-h\$&!]|BqIsA-/1Dn__c<7}MM1exg8L(RF]k76r<)2Q,rd+!@D.?A~5}');
define('NONCE_KEY',        'w-pu%qX{.JE+hQ)(!O#rU>dyFp2bpC9=o^+{zT^i}F.R(~8z!KB\$cj.A|W.-I6\`i');
define('AUTH_SALT',        '|r03el]D<~u8ozz7Z0*McTCD-s7|P>\$?UdEF+!L<,(i4eSrJy(]hS3IVpSBM@\`,i');
define('SECURE_AUTH_SALT', '#?MQ=]~8?:GFEp1-=&\`d@7(.KzQZ/n|A/F\`ArfDn]6yu}Up2v+PCD+P}+a?(uEvA');
define('LOGGED_IN_SALT',   '_N.|rQYnowY|kw/7|2OUtZ(*lZ]A!ayMsu3u|LKw_5xAL/?Aua3tzbZ0nS=F@-lt');
define('NONCE_SALT',       '#\`Qn\$ka^[8jO~o%xX,_~*PcwsI]\$hSIK@3eZlR\`q_;@+kV(8d?+Mq16Fy!5~yWPB');

if (!defined('ABSPATH')) {
    define('ABSPATH', __DIR__ . '/');
}
require_once ABSPATH . 'wp-settings.php';
