Composer
========

Easily install ``composer``, the Dependency Manager for PHP.

Installation
------------

Class name: ``php::composer``

* ``$source`` defaults to ``https://getcomposer.org/composer.phar``

* ``$destination`` defaults to ``/usr/local/bin/composer``

Auto update
-----------

Automatically update composer every ``$max_age`` days

Class name: ``php::composer::auto_update``

* ``$max_age`` defaults to ``30`` (days)

* ``$source`` defaults to ``https://getcomposer.org/composer.phar``

* ``$destination`` defaults to ``/usr/local/bin/composer``

Examples
--------

.. code-block:: puppet

  # Install with defaults
  class { 'php::composer':

  }

  # Install with defaults + auto-update
  class { ['php::composer', 'php::composer::auto_update']:

  }

  # Install from different source
  class { 'php::composer':
    source => 'https://example.com/composer.phar'
  }

  # Install to different destination
  class { 'php::composer':
    destination => '/usr/bin/composer'
  }
