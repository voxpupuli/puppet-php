# == Class: php::pecl::curl
#
# Install the curl PHP extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*php_version*]
#   The version of curl to install
#
# === Examples
#
#  include php::pecl::curl
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::curl(
	$version = $php::params::version
) inherits php::params {

  class { 'php::pecl::curl::package':
  	version => $version
  }

  class { 'php::pecl::curl::config': }

}
