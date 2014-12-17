# puppet-php

[![Build Status](https://travis-ci.org/Mayflower/puppet-php.svg?branch=master)](https://travis-ci.org/Mayflower/puppet-php)

``puppet-php`` is a Puppet module for managing PHP, in particular php-fpm.

This originally was a fork of [jippi/puppet-php](https://github.com/jippi/puppet-php)
(nodes-php on Puppet Forge) but has since been rewritten in large parts.

## Usage

The module aims to use sane defaults for the supported architectures. You
must use hiera to configure most aspects of this module.

The recommended way is to include the `php` main class in your manifests:

```puppet
include ::php
```

You can configure the module through hiera. Here are the defaults for some
parameters as you would specify them in hiera:

```yaml
php::ensure: latest
php::manage_repos: true
php::fpm: true
php::dev: true
php::composer: true
php::pear: true
php::phpunit: false
php::fpm::config:log_level: notice
php::composer::auto_update: true
```

There are more configuration options available. Please refer to the
documention in the manifests for a complete overview.

### Apache support

Apache with `mod_php` is not supported by this module. Please use
[puppetlabs/apache](https://forge.puppetlabs.com/puppetlabs/apache) instead.

We prefer using php-fpm. You can find an example Apache vhost in
`manifests/apache_vhost.pp` that shows you how to use `mod_proxy_fcgi` to
connect to php-fpm.

### Defining `php.ini` settings

PHP configuration parmaters in `php.ini` files can be defined as parameter
`settings` on the `php`, `php::fpm` and `php::cli` classes or
`php::extension` resources for each component independently.

These settings are written into their respective `php.ini` file. Global
settings in `php::settings` are merged with the settings of all components.
Please note that settings of extensions are always independent.

In the following example the timezone will be set in the PHP cli application
and all php-fpm pools.

```yaml
php::settings:
  Date/date.timezone: Europe/Berlin
php::cli::settings:
  PHP/memory_limit: 512M
php::fpm::settings:
  PHP/short_open_tag: 'On'
```

### Installing extensions

Extensions can be installed and configured by defining the hash
`php::extensions` in hiera. They are activated for all activated components.

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

