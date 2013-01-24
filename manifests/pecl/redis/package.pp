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
class php::pecl::redis::package(
  $version  = $php::pecl::redis::params::version
) inherits php::pecl::redis::params {

  file {
    "${tmp_dir}":
      ensure   => "directory",
      recurse  => true;
  }

  exec {
    'redis_fetch':
      command => "wget https://github.com/nicolasff/phpredis/archive/${version}.tar.gz",
      creates => "${tmp_dir}/${version}.tar.gz",
      cwd     => "${tmp_dir}";

    'redis_extract':
      command => "tar zxf ${version}.tar.gz",
      creates => "${tmp_dir}/phpredis-${version}",
      cwd     => "${tmp_dir}";

    "redis_phpize":
      command => "phpize",
      creates => "${tmp_dir}/phpredis-${version}/configure",
      cwd     => "${tmp_dir}/phpredis-${version}";

    "redis_configure":
      command => "bash -c -- ./configure",
      creates => "${tmp_dir}/phpredis-${version}/config.status",
      cwd     => "${tmp_dir}/phpredis-${version}";

    "redis_make":
      command => "make",
      creates => "${tmp_dir}/phpredis-${version}/modules/redis.so",
      cwd     => "${tmp_dir}/phpredis-${version}";

    "redis_install":
      command => "make install",
      creates => "${install_dir}/redis.so",
      cwd     => "${tmp_dir}/phpredis-${version}";
  }

  File["${tmp_dir}"]
    -> Exec["redis_fetch"]
    -> Exec["redis_extract"]
    -> Exec["redis_phpize"]
    -> Exec["redis_configure"]
    -> Exec["redis_make"]
    -> Exec["redis_install"]

}
