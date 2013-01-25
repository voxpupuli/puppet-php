# == Class: php::extension::mcrypt
#
# Install and configure the mcrypt PHP extension
#
# === Parameters
#
# [*version*]
#   The version of mcrypt to install
#   Could be "latest", "installed" or a pinned verison
#
# [*package*]
#   The package name for mcrypt
#   For debian it's php5-mcrypt
#
# [*provider*]
#   The provider used to install php5-mcrypt
#   Could be "pecl", "apt" or any other OS package provider
#
# [*config_file*]
#   The path to the ini php5-mcrypt ini file
#
# [*config_changes*]
#	Hash with 'set' nested hash of key => value
#	set changes to agues when applied to *config_file*
#
# === Variables
#
# [*php_version*]
#   The version of mcrypt to install
#
# === Examples
#
#  include php::extension::mcrypt
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::extension::mcrypt(
  $version  			= $php::extension::mcrypt::params::version,
  $package 			 	= $php::extension::mcrypt::params::package,
  $provider 			= $php::extension::mcrypt::params::provider,
  $config_file    = $php::extension::mcrypt::params::config_file,
  $config_changes = $php::extension::mcrypt::params::config_changes
) inherits php::extension::mcrypt::params {

  php::extension { 'mcrypt':
    version  => $version,
    package  => $package,
    provider => $provider
  }

  php::config { 'php-extension-mcrypt':
    config_file     => $config_file,
    config_changes  => $config_changes
  }

}
