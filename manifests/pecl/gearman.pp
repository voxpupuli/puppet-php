# == Class: php::pecl::gearman
#
# Install the gearman PHP extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*php_version*]
#   The version of gearman to install
#
# === Examples
#
#  include php::pecl::gearman
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::gearman(
	$version = $php::params::version
) inherits php::params {

  class { 'php::pecl::gearman::package':
  	version => $version
  }

  class { 'php::pecl::gearman::config': }

}
