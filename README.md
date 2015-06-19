# mayflower/php Puppet Module

[![GitHub version](https://badge.fury.io/gh/mayflower%2Fpuppet-php.svg)](https://github.com/mayflower/puppet-php)
[![Build Status](https://travis-ci.org/mayflower/puppet-php.svg?branch=master)](https://travis-ci.org/mayflower/puppet-php)

mayflower/php is a Puppet module for managing PHP with a strong focus
on php-fpm. We strive to support all recent versions of Debian, Ubuntu,
RedHat/CentOS, openSUSE/SLES and FreeBSD. Managing Apache with `mod_php`
is not supported.

This originally was a fork of [jippi/puppet-php](https://github.com/jippi/puppet-php)
(nodes-php on Puppet Forge) but has since been rewritten in large parts.

## Usage

The module aims to use sane defaults for the supported architectures. You
must use hiera to configure most aspects of this module in a simple way.

The recommended way is to include the `php` main class in your manifests:

```puppet
include ::php
```

You can configure the module through hiera. Here are the defaults for some
parameters as you would specify them in hiera:

```
php::ensure: latest
php::manage_repos: true
php::fpm: true
php::dev: true
php::composer: true
php::pear: true
php::phpunit: false
php::fpm::config::log_level: notice
php::composer::auto_update: true
```

There are more configuration options available. Please refer to the
auto-generated documention at http://php.puppet.mayflower.de/.

### Defining `php.ini` settings

PHP configuration parmaters in `php.ini` files can be defined as parameter
`settings` on the `php`, `php::fpm` and `php::cli` classes or
`php::extension` resources for each component independently.

These settings are written into their respective `php.ini` file. Global
settings in `php::settings` are merged with the settings of all components.
Please note that settings of extensions are always independent.

In the following example the timezone will be set in the PHP cli application
and all php-fpm pools.

```
php::settings:
  Date/date.timezone: Europe/Berlin
php::cli::settings:
  PHP/memory_limit: 512M
php::fpm::settings:
  PHP/short_open_tag: 'On'
```

### Installing extensions

Extensions can be installed and configured by defining the hash
`php::extensions` in hiera. They are activated for all activated SAPIs.

```
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

See [the documentation](http://php.puppet.mayflower.de/php/extension.html)
of the `php::extension` resource for all available parmeters and default
values.

### Defining php-fpm pools

If different php-fpm pools are required, you can use `php::fpm::pool`
resources. Use the parameter `$pools` from the class `php::fpm` to define
`php::fpm::pool` resources as a hash from hiera.

If not defined in your hiera data, a single pool called `www` will be
configured by default:

```
php::fpm::pools:
  www:
    listen: 127.0.0.1:9000
```

For an overview of all possible parameters for `php::fpm::pool` resources
please see [its documention](http://php.puppet.mayflower.de/php/fpm/pool.html).

## Notes

### Debian squeeze & Ubuntu precise come with PHP 5.3

On Debian-based systems, we use `php5enmod` to enable extension-specific
configuration. This script is only present in `php5` packages beginning with
version 5.4. Furthermore, PHP 5.3 is not supported by upstream anymore.

We strongly suggest you use a recent PHP version, even if you're using an
older though still supported distribution release. Our default is to have
`php::manage_repos` enabled to add apt sources for
[Dotdeb](http://www.dotdeb.org/) on Debian and
[ppa:ondrej/php5](https://launchpad.net/~ondrej/+archive/ubuntu/php5/) on
Ubuntu with packages for the current stable PHP version closely tracking
upstream.

### Apache support

Apache with `mod_php` is not supported by this module. Please use
[puppetlabs/apache](https://forge.puppetlabs.com/puppetlabs/apache) instead.

We prefer using php-fpm. You can find an example Apache vhost in
`manifests/apache_vhost.pp` that shows you how to use `mod_proxy_fcgi` to
connect to php-fpm.

### FreeBSD support

On FreeBSD systems we purge the system-wide `extensions.ini` in favour of
per-module configuration files.

Please also note that support for Composer and PHPUnit on FreeBSD is untested
and thus likely incomplete.

## Bugs & New Features

If you happen to stumble upon a bug, please feel free to create a pull request
with a fix (optionally with a test), and a description of the bug and how it
was resolved.

Or if you're not into coding, simply create an issue adding steps to let us
reproduce the bug and we will happily fix it.

If you have a good idea for a feature or how to improve this module in general,
please create an issue to discuss it. We are very open to feedback. Pull
requests are always welcome.

We hate orphaned and unmaintained Puppet modules as much as you do and
therefore promise that we will continue to maintain this module and keep
response times to issues short. If we happen to lose interest, we will write
a big fat warning into this README to let you know.

## License

The project is released under the permissive MIT license.

The source can be found at
[github.com/mayflower/puppet-php](https://github.com/mayflower/puppet-php/).

This Puppet module is being actively maintained by some fellow puppeteers at
[Mayflower GmbH](https://mayflower.de).
