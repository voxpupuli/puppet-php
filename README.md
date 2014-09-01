# puppet-php

[![Build Status](https://travis-ci.org/Mayflower/puppet-php.svg?branch=master)](https://travis-ci.org/Mayflower/puppet-php)

``puppet-php`` is a Puppet module for managing PHP, in particular php-fpm.

This originally was a fork of [jippi/puppet-php](https://github.com/jippi/puppet-php)
(nodes-php on Puppet Forge) but has since been rewritten in large parts.

## Usage

The module aims to use sane defaults and be easily configurable with hiera.

The recommended way is to use the main class to install php with following defaults:

```puppet
class { '::php':
  manage_repos => true,
  fpm          => true,
  dev          => true,
  composer     => true,
  pear         => true,
  phpunit      => false,
  extensions   => {}
}
```

### Apache support

Apache with `mod_php` is not supported by this module. Please use
[puppetlabs/apache](https://forge.puppetlabs.com/puppetlabs/apache) instead.

We prefer using php-fpm. You can find an example Apache vhost in
`manifests/apache_vhost.pp` that shows you how to use `mod_proxy_fcgi` to
connect to php-fpm.

### Defining php.ini settings

Can be defined as parameter `settings` on `php::{fpm, cli}` classes or
`php::extension` resources. The recommended way is to use hiera:

```yaml
php::cli::settings:
  Date/date.timezone: Europe/London
  PHP/short_open_tag: 'On'
```

### Installing extensions

Extensions can be installed either by using the parameter `extensions` in
the main class or by defining the hash `php::extensions` in hiera.

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
    settings:
      apc.stat: 1
      apc.stat_ctime: 1
```

## Source Code

The source can be found at
[github.com/Mayflower/puppet-php](https://github.com/Mayflower/puppet-php/).

## Bugs & New Features

If you happen to stumble upon a bug, please feel free to create a pull request
with a fix (optionally with a test), and a description of the bug and how it
was resolved.

Or simply create an issue adding steps to let us reproduce the bug.

If you have a good idea for a feature, please create an issue to discuss it.
Pull requests are always more than welcome.

## License

The project is released under the permissive MIT license.

