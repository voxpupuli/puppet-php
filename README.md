Introduction
============

[![Build Status](https://travis-ci.org/Mayflower/puppet-php.svg?branch=master)](https://travis-ci.org/Mayflower/puppet-php)

``puppet-php`` is a module for managing PHP using puppet.

This originally was a fork of [jippi/puppet-php](https://github.com/jippi/puppet-php)
(nodes-php on Puppet Forge) but has since been rewritten in large parts.

Documentation
-------------

The module aims to use sane defaults and be easily configurable with hiera.

The recommended way is to use the main class to install php with following defaults.

```puppet
class { '::php':
  manage_repos => true,
  fpm          => true,
  apache       => false,
  dev          => true,
  composer     => true,
  pear         => true,
  phpunit      => false,
  extensions   => {}
}
```

### Installing extensions

Extensions can be installed either by using the parameter on the main class or by
defining the hash `php::extension` in hiera.

```yaml
php::extensions:
  json: {}
  mysql: {}
  memcached:
    provider: pecl
    header_packages:
      - libmemcached-dev
  apc:
    package_prefix: php-
    config:
      apc.stat: 1
      apc.stat_ctime: 1
```

### Defining php.ini settings

Settings can be defined on php::{fpm, cli, apache} classes or as parameter to an extension.
The recommended way is to use hiera to set these:

```yaml
php::cli::settings:
  Date/date.timezone: Europe/London
  PHP/short_open_tag: 'On'
```

Source Code
-----------

The source can be found at [github.com/Mayflower/puppet-php](https://github.com/Mayflower/puppet-php/)

License
-------

The project is released under the permissive MIT license.

Bugs
----

If you happen to stumble upon a bug, please feel free to create a pull request with a fix
(optionally with a test), and a description of the bug and how it was resolved.

Or simply create an issue adding steps to let us reproduce the bug.

Features
--------

If you have a good idea for a feature, please create an issue to discuss it.
Pull requests are always more than welcome.
