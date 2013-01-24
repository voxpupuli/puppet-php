# == Class: php::pecl::uploadprogress
#
# Install and configure the uploadprogress PHP extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*php_version*]
#   The version of uploadprogress to install
#
# === Examples
#
#  include php::pecl::uploadprogress
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::uploadprogress(
	$version = $php::params::version
) inherits php::params {

  class { 'php::pecl::uploadprogress::package':
  	version => $version
  }

  class { 'php::pecl::uploadprogress::config': }

}
