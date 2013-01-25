# == Class: php::pecl::redis
#
# Install and configure the redis PHP extension
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
#  include php::pecl::redis
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::redis(
	$version = 'master'
) inherits php::params {

  class { 'php::pecl::redis::package':
  	version => $version
  }

  class { 'php::pecl::redis::config': }

}
