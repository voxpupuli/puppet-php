# == Class: php::extension::mysql
#
# Install and configure the mysql PHP extension
#
# === Parameters
#
# [*version*]
#   The version of mysql to install
#   Could be "latest", "installed" or a pinned verison
#
# [*package*]
#   The package name for mysql
#   For debian it's php5-mysql
#
# [*provider*]
#   The provider used to install php5-mysql
#   Could be "pecl", "apt" or any other OS package provider
#
# [*config_file*]
#   The path to the ini php5-mysql ini file
#
# [*config_changes*]
#		Hash with 'set' nested hash of key => value
#		set changes to agues when applied to *config_file*
#
# === Variables
#
# [*php_version*]
#   The version of mysql to install
#
# === Examples
#
#  include php::extension::mysql
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::extension::mysql(
  $version  			= $php::extension::mysql::params::version,
  $package  			= $php::extension::mysql::params::package,
  $provider 			= $php::extension::mysql::params::provider,
  $config_file    = $php::extension::mysql::params::config_file,
  $config_changes = $php::extension::mysql::params::config_changes,
) inherits php::extension::mysql::params {

  php::extension { 'mysql':
    version  => $version,
    package  => $package,
    provider => $provider
  }

  php::config { 'php-extension-mysql':
    config_file     => $config_file,
    config_changes  => $config_changes
  }

}
