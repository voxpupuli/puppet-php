phpunit
=======

Install PHPunit

Installation
------------

Class: ``php::phpunit``

* ``$ensure`` defaults to ``installed``

* ``$package`` defaults to ``pear.phpunit.de/PHPUnit``

* ``$provider`` defaults to ``pear``


Examples
--------

.. code-block:: puppet

  # Install with defaults
  class { 'php::phpunit':

  }

  # Install with auto-update
  class { 'php::phpunit':
    ensure => latest
  }

  # Install with sticky version
  class { 'php::phpunit':
    ensure => '3.7.29'
  }
