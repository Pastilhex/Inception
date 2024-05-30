<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * Localized language
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'my_db' );

/** Database username */
define( 'DB_USER', 'my_user' );

/** Database password */
define( 'DB_PASSWORD', 'my_pass' );

/** Database hostname */
define( 'DB_HOST', 'mariadb' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',          '%u,<xcVUQ$5OQOA%]Yrx4}+[*&wI5+=<f{AZU>.w2LdN6bZZeymuwIn1t.-$=++D' );
define( 'SECURE_AUTH_KEY',   '=bq4>o/(q> X`xUAT<cl9DbhS5<5.&w^{&rB=mQ`sH_wYjl;xi(I|rch<snDqSlo' );
define( 'LOGGED_IN_KEY',     ';Eze8_ohm1yBkQ+oh@~QcuVsQ8a+&$KOQ>z!1`0ZyLsjbD|p%E/.sScmbMY`KeMy' );
define( 'NONCE_KEY',         '{GEUyIg<@,&>O[2)2U:mb hD>kCnGI=g>;K36*Adnc]skw;5eRyIMMOVv1Tx!r8&' );
define( 'AUTH_SALT',         'qDqofDn++>tT(mhrMOqiRxItna!}]MCdWg-Hfl>HkCs/&?)&]r_z&cOo];5-DLcX' );
define( 'SECURE_AUTH_SALT',  'IGK;PWqS1}6G}|NX>3CM$sY8$T*Cfxca%wQ;r7=pzS}#9?DmOp%!f6wN1=2q3ELe' );
define( 'LOGGED_IN_SALT',    '5A(Ky*PNkXb8ef(DY7?CEwGH2.3 lues*I]SrRDWN]YLq)V_bycVE71er6i[uHv{' );
define( 'NONCE_SALT',        ',+pJP{rZw3a#(+X,*e#wf2]zuK)4U`Uz>7kkR#opq/C~3N_l:Jb{{{<Djo_50}Dz' );
define( 'WP_CACHE_KEY_SALT', 'EI-IS:6!Svcy6?WsqH92zs78 Hz[qCXBjLkSE;;X8b#S%)qhF`!z>V-Xc4]7x]4!' );


/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';


/* Add any custom values between this line and the "stop editing" line. */



/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
if ( ! defined( 'WP_DEBUG' ) ) {
	define( 'WP_DEBUG', false );
}

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
