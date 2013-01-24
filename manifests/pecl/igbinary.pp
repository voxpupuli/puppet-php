# == Class: php::pecl::igbinary
#
# Install and configure the igbinary PHP extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*php_version*]
#   The version of igbinary to install
#
# === Examples
#
#  include php::pecl::igbinary
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::igbinary(
	$version = $php::params::version
) inherits php::params {

  class { 'php::pecl::igbinary::package':
  	version => $version
  }

  class { 'php::pecl::igbinary::config': }

}
