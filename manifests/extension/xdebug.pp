# == Class: php::extension::xdebug
#
# Install and configure the xdebug PHP extension
#
# === Parameters
#
# [*version*]
#   The version of xdebug to install
#   Could be "latest", "installed" or a pinned verison
#
# [*package*]
#   The package name for xdebug
#   For debian it's php5-xdebug
#
# [*provider*]
#   The provider used to install php5-xdebug
#   Could be "pecl", "apt" or any other OS package provider
#
# [*config_file*]
#   The path to the ini php5-xdebug ini file
#
# [*config_changes*]
# 	Hash with 'set' nested hash of key => value
# 	set changes to agues when applied to *config_file*
#
# === Variables
#
# [*php_version*]
#   The version of xdebug to install
#
# === Examples
#
#  include php::extension::xdebug
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::extension::xdebug(
  $version  			= $php::extension::xdebug::params::version,
  $package  			= $php::extension::xdebug::params::package,
  $provider 			= $php::extension::xdebug::params::provider,
  $config_file    = $php::extension::xdebug::params::config_file,
  $config_changes = $php::extension::xdebug::params::config_changes
) inherits php::extension::xdebug::params {

  php::extension { 'xdebug':
    version  => $version,
    package  => $package,
    provider => $provider
  }

  php::config { 'php-extension-xdebug':
    config_file     => $config_file,
    config_changes  => $config_changes
  }

}
