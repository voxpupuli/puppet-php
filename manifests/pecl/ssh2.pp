# == Class: php::pecl::ssh2
#
# Install and configure the ssh2 PHP extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*php_version*]
#   The version of ssh2 to install
#
# === Examples
#
#  include php::pecl::ssh2
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::ssh2(
	$version = $php::params::version
) inherits php::params {

  class { 'php::pecl::ssh2::package':
  	version => $version
  }

  class { 'php::pecl::ssh2::config': }

}
