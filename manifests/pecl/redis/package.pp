# == Class: php::pecl::mysql::package
#
# Install the PHP redis extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*php_version*]
#   The version of redis to install
#
# === Examples
#
#  include php::pecl::redis::package
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::redis::package {

  file {
    '/opt/php':
      ensure   => 'directory',
      recurse  => true;

    '/opt/php/phpredis':
      ensure   => 'directory',
      recurse  => true;
  }

  exec {
    'redis_fetch':
      command => 'wget https://github.com/nicolasff/phpredis/archive/2.2.2.tar.gz',
      creates => '/opt/php/phpredis/2.2.2.tar.gz',
      cwd     => '/opt/php/phpredis';

    'redis_extract':
      command => 'tar zxf 2.2.2.tar.gz',
      creates => '/opt/php/phpredis/phpredis-2.2.2',
      cwd     => '/opt/php/phpredis';

    'redis_phpize':
      command => 'phpize',
      creates => '/opt/php/phpredis/phpredis-2.2.2/configure',
      cwd     => '/opt/php/phpredis/phpredis-2.2.2';

    'redis_configure':
      command => 'bash -c -- ./configure',
      creates => '/opt/php/phpredis/phpredis-2.2.2/config.status',
      cwd     => '/opt/php/phpredis/phpredis-2.2.2';

    'redis_make':
      command => 'make',
      creates => '/opt/php/phpredis/phpredis-2.2.2/modules/redis.so',
      cwd     => '/opt/php/phpredis/phpredis-2.2.2';

    'redis_install':
      command => 'make install',
      creates => '/usr/lib/php5/20100525/redis.so',
      cwd     => '/opt/php/phpredis/phpredis-2.2.2';
  }

  Package['php5-dev']
    -> File['/opt/php']
    -> File['/opt/php/phpredis']
    -> Exec['redis_fetch']
    -> Exec['redis_extract']
    -> Exec['redis_phpize']
    -> Exec['redis_configure']
    -> Exec['redis_make']
    -> Exec['redis_install']

  if defined(Service['apache2']) {
    Exec['redis_install'] ~> Service['apache2']
  }

}
