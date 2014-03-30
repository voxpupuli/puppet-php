SAPI
####

``puppet-php`` currently supports the SAPIs shown below.

Common arguments
----------------

These arguments are available for all SAPIs, though their defaults may be
different across SAPIs.

* ``$ensure`` defaults to ``installed``.

* ``$package`` default depends on SAPI.

* ``$provider``` default to ``undef``.

* ``$inifile`` default depends on SAPI.

* ``$settings`` defaults to ``[ ]`` (empty array).

php::apache
-----------

Installs the ``mod_php`` PHP SAPI for apache.

* ``$package`` defaults to ``libapache2-mod-php5``.

* ``$inifile`` defaults to ``/etc/php5/apache2/php.ini``.

* ``$service_name`` defaults to ``apache2``.

.. note ::

  This class will **not** install Apache for you, please use a relevant module
  for that.

php::fpm
--------

Installs the ``FPM`` PHP SAPI.

* ``$package`` defaults to ``php5-fpm``.

* ``$inifile`` defaults to ``/etc/php5/fpm/php.ini``.

* ``$service_name`` defaults to ``php5-fpm``.

* ``$service_ensure`` defaults to ``running``.

* ``$service_enable`` defaults to ``true``.

* ``$service_has_status`` defaults to ``true``.


php::cli
--------

Installs the ``CLI`` PHP SAPI.

* ``$package`` defaults to ``php5-cli``.

* ``$inifile`` defaults to ``/etc/php5/cli/php.ini``.

