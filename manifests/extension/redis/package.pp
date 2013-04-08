# == Class: php::extension::mysql::package
#
# Install the PHP redis extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# No variables
#
# === Examples
#
#  include php::extension::redis::package
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::extension::redis::package(
  $ensure  = $php::extension::redis::params::ensure,
  $tmp_dir  = $php::extension::redis::params::tmp_dir
) {
  include php::extension::redis::params

  file { php::extension::redis::params::tmp_dir :
      ensure   => directory,
      recurse  => true;
  }

  exec {
    'redis_fetch':
      command => "wget https://github.com/nicolasff/phpredis/archive/${ensure}.tar.gz",
      creates => "${tmp_dir}/${ensure}.tar.gz",
      cwd     => php::extension::redis::params::tmp_dir,
      path    => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ];

    'redis_extract':
      command => "tar zxf ${ensure}.tar.gz",
      creates => "${tmp_dir}/phpredis-${ensure}",
      cwd     => php::extension::redis::params::tmp_dir,
      path    => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ];

    'redis_phpize':
      command => 'phpize',
      creates => "${tmp_dir}/phpredis-${ensure}/configure",
      cwd     => "${tmp_dir}/phpredis-${ensure}";

    'redis_configure':
      command => 'bash -c -- ./configure',
      creates => "${tmp_dir}/phpredis-${ensure}/config.status",
      cwd     => "${tmp_dir}/phpredis-${ensure}",
      path    => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ];

    'redis_make':
      command => 'make',
      creates => "${tmp_dir}/phpredis-${ensure}/modules/redis.so",
      cwd     => "${tmp_dir}/phpredis-${ensure}",
      path    => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ];

    'redis_install':
      command => 'make install',
      creates => "${php::extension::redis::params::install_dir}/redis.so",
      cwd     => "${tmp_dir}/phpredis-${ensure}",
      path    => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ];
  }

  File[tmp_dir]
    -> Class['php::dev']
    -> Exec['redis_fetch']
    -> Exec['redis_extract']
    -> Exec['redis_phpize']
    -> Exec['redis_configure']
    -> Exec['redis_make']
    -> Exec['redis_install']

}
