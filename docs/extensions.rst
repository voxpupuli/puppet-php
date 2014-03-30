Extensions
##########

Common arguments
----------------

These arguments are available for all extensions, though their defaults may be
different across SAPIs.

* ``$ensure`` defaults to ``installed``.

* ``$package`` default depends on extension.

* ``$provider``` default depends on extension.

* ``$inifile`` default depends on extension.

* ``$settings`` defaults to ``[ ]`` (empty array).

apc
---

Class name: ``php::extension::apc``.

* ``$package`` defaults to ``php-apc`` for Squeeze, Wheezy, Lucid, Precise, Quantal and Raring. Other OS versions will default to ``php5-apcu``.

* ``$inifile`` defaults to ``${php::params::config_root_ini}/apc.ini``

apcu
----

Class name: ``php::extension::apcu``.

* ``$package`` defaults to ``php5-apcu``

* ``$inifile`` defaults to ``${php::params::config_root_ini}/apcu.ini``

curl
----

Class name: ``php::extension::curl``.

* ``$package`` defaults to ``php5-curl``

* ``$inifile`` defaults to ``${php::params::config_root_ini}/curl.ini``

gd
--

Class name: ``php::extension::gd``.

* ``$package`` defaults to ``php5-curl``

* ``$inifile`` defaults to ``${php::params::config_root_ini}/gd.ini``

gearman
-------

Class name: ``php::extension::gearman``.

* ``$package`` defaults to ``php5-gearman``

* ``$inifile`` defaults to ``${php::params::config_root_ini}/gearman.ini``

http
----

Class name: ``php::extension::http``.

* ``$package`` defaults to ``php5-http``

* ``$inifile`` defaults to ``${php::params::config_root_ini}/http.ini``

igbinary
--------

.. note::

  The package requires the ``build-essential`` and ``php5-dev`` system packages.

Class name: ``php::extension::igbinary``.

* ``$package`` defaults to ``igbinary``

* ``$provider`` defaults to ``pecl``

* ``$inifile`` defaults to ``${php::params::config_root_ini}/igbinary.ini``

* ``$settings`` defaults to ``['set ".anon/extension" "igbinary.so"']``

imagick
-------

Class name: ``php::extension::imagick``.

* ``$package`` defaults to ``php5-imagick``

* ``$inifile`` defaults to ``${php::params::config_root_ini}/imagick.ini``

imap
----

Class name: ``php::extension::imap``.

* ``$package`` defaults to ``php5-imap``

* ``$inifile`` defaults to ``${php::params::config_root_ini}/imap.ini``

intl
----

Class name: ``php::extension::intl``.

* ``$package`` defaults to ``php5-intl``

* ``$inifile`` defaults to ``${php::params::config_root_ini}/intl.ini``

ldap
----

FIX ME

Class name: ``php::extension::ldap``.

* ``$package`` defaults to ``php5-ldap``

* ``$inifile`` defaults to ``${php::params::config_root_ini}/ldap.ini``

mcrypt
------

Class name: ``php::extension::mcrypt``.

* ``$package`` defaults to ``php5-mcrypt``

* ``$inifile`` defaults to ``${php::params::config_root_ini}/mcrypt.ini``

memcache
--------

FIX ME

Class name: ``php::extension::memcache``.

* ``$package`` defaults to ``php5-memcache``

* ``$inifile`` defaults to ``${php::params::config_root_ini}/memcache.ini``

memcached
---------

FIX ME

Class name: ``php::extension::memcached``.

* ``$package`` defaults to ``php5-memcached``

* ``$inifile`` defaults to ``${php::params::config_root_ini}/memcached.ini``

mysql
-----

Class name: ``php::extension::mysql``.

* ``$package`` defaults to ``php5-mysql``

* ``$inifile`` defaults to ``${php::params::config_root_ini}/mysql.ini``

newrelic
--------

.. note ::

  This extension requires the NewRelic PHP apt repository to be added beforehand.

Class name: ``php::extension::newrelic``.

* ``$package`` defaults to ``php5-newrelic``

* ``$inifile`` defaults to ``${php::params::config_root_ini}/newrelic.ini``

opcache
-------

Class name: ``php::extension::opcache``.

* ``$package`` defaults to ``undef``

* ``$inifile`` defaults to ``${php::params::config_root_ini}/opcache.ini``


pgsql
-----

Class name: ``php::extension::pgsql``.

* ``$package`` defaults to ``php5-pgsql``

* ``$inifile`` defaults to ``${php::params::config_root_ini}/pgsql.ini``

redis
-----

Class name: ``php::extension::redis``.

* ``$package`` defaults to ``php5-redis``

* ``$inifile`` defaults to ``${php::params::config_root_ini}/redis.ini``

ssh2
----

Class name: ``php::extension::ssh2``.

* ``$package`` defaults to ``php5-ssh2``

* ``$inifile`` defaults to ``${php::params::config_root_ini}/ssh2.ini``

uploadprogess
-------------

.. note::

  The package requires the ``build-essential`` and ``php5-dev`` system packages.

Class name: ``php::extension::uploadprogess``.

* ``$package`` defaults to ``uploadprogess``

* ``$provider`` defaults to ``pecl``

* ``$inifile`` defaults to ``${php::params::config_root_ini}/uploadprogess.ini``

* ``$settings`` defaults to ``['set ".anon/extension" "uploadprogess.so"']``

xcache
------

FIX ME

Class name: ``php::extension::xcache``.

* ``$package`` defaults to ``php5-xcache``

* ``$inifile`` defaults to ``${php::params::config_root_ini}/xcache.ini``

xdebug
------

FIX ME

Class name: ``php::extension::xdebug``.

* ``$package`` defaults to ``php5-xdebug``

* ``$installdir`` defaults to ``/usr/lib/php5/20121212``

* ``$inifile`` defaults to ``${php::params::config_root_ini}/xdebug.ini``

* ``$settings`` defaults to ``["set .anon/zend_extension '${install_dir}/xdebug.so'"]``
