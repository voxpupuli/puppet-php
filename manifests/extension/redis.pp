# == Class: php::extension::redis
#
# Install and configure the redis PHP extension
#
# === Parameters
#
# [*ensure*]
#   The version of the package to install
#   Could be "latest", "installed" or a pinned version
#   This matches "ensure" from Package
#
# [*config_file*]
#   The path to the extension ini file
#
# [*config_changes*]
#   Hash with 'set' nested hash of key => value
#   set changes to agues when applied to *config_file*
#
# === Variables
#
# No variables
#
# === Examples
#
#  include php::extension::redis
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::extension::redis(
	$ensure 				= 'master',
	$config_file    = $php::extension::redis::params::config_file,
  $config_changes = $php::extension::redis::params::config_changes
) inherits php::extension::redis::params {

  class { 'php::extension::redis::package':
  	ensure => $ensure
  }

  php::config { 'php-extension-redis':
    config_file     => $config_file,
    config_changes  => $config_changes
  }

}
