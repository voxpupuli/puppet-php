Introduction
============

``puppet-php`` is a module for managing PHP using puppet.

Documentation
-------------

The module aims to use sane defaults and be easily configurable with hiera.

The recommended way is to use the main class to install php with following defaults.

```
  class { '::php':
    manage_repos => true,
    fpm          => true,
    apache       => false,
    dev          => true,
    composer     => true,
    pear         => true,
    extensions   => {}
  }
```

Installing extensions

Extensions can be installed either by using the parameter on the main class or by defining the hash `php::extension` in hiera.

```
php::extensions:
  json: {}
  mysql: {}
  pecl-memcached:
    provider: pecl
    header_packages:
      - libmemcached-dev
```

Source code
-----------

The source can be found at [github.com/Mayflower/puppet-php](https://github.com/Mayflower/puppet-php/)

License
-------

The project is released under the permissive MIT license.

Bugs
----

If you happen to stumble upon a bug, please feel free to create a pull request with a fix
(optionally with a test), and a description of the bug and how it was resolved.

You can also create an issue with a description to raise awareness of the bug.

Features
--------

If you have a good idea for a feature, please join us on IRC and let's discuss it.
Pull requests are always more than welcome.
