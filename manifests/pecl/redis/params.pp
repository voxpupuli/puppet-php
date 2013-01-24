# == Class: php::pecl::redis::params
#
# Defaults file for redis extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*version*]
#   The version of redis to install
#   Must be a valid tag/branch name from the github repo
#	Please see https://github.com/nicolasff/phpredis/
#
# [*tmp_dir*]
#   tmp folder to store and compile redis extension from
#
# [*install_dir*]
#   Path where `make install` in the php extension will
#	put the redis.so file
#
# [*config_file*]
#   The path to the ini php5-redis ini file
#
# [*config_changes*]
#   Hash with 'set' nested hash of key => value
#   set changes to agues when applied to *config_file*
#
# === Examples
#
#  include 'php::pecl::redis::package'
#
#  class {'php::pecl::redis::package':
#   version => latest
#  }
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::redis::params {

  $version        = 'master'
  $tmp_dir		  = '/opt/php/phpredis'
  $install_dir	  = '/usr/lib/php5/20100525'
  $config_file    = '/etc/php5/conf.d/redis.ini'
  $config_changes = {
    set => {
      '.anon/extension' => 'redis.so'
    }
  }

}
