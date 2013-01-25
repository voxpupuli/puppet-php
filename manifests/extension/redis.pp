# == Class: php::extension::redis
#
# Install and configure the redis PHP extension
#
# === Parameters
#
# [*version*]
#   The version of redis to install
#   Must be a valid tag/branch name from the github repo
#		Please see https://github.com/nicolasff/phpredis/
#
# [*config_file*]
#   The path to the ini php5-redis ini file
#
# [*config_changes*]
# 	Hash with 'set' nested hash of key => value
# 	set changes to agues when applied to *config_file*
#
# === Variables
#
# [*php_version*]
#   The version of redis to install
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
	$version 				= 'master',
	$config_file    = $php::extension::redis::params::config_file,
  $config_changes = $php::extension::redis::params::config_changes
) inherits php::extension::redis::params {

  class { 'php::extension::redis::package':
  	version => $version
  }

  php::config { 'php-extension-redis':
    config_file     => $config_file,
    config_changes  => $config_changes
  }

}
