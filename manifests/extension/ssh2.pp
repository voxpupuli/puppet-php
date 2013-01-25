# == Class: php::extension::ssh2
#
# Install and configure the ssh2 PHP extension
#
# === Parameters
#
# [*version*]
#   The version of ssh2 to install
#   Could be "latest", "installed" or a pinned verison
#
# [*package*]
#   The package name for ssh2
#   For debian it's php5-ssh2
#
# [*provider*]
#   The provider used to install php5-ssh2
#   Could be "pecl", "apt" or any other OS package provider
#
# [*config_file*]
#   The path to the ini php5-ssh2 ini file
#
# [*config_changes*]
#		Hash with 'set' nested hash of key => value
#		set changes to agues when applied to *config_file*
#
# === Variables
#
# [*php_version*]
#   The version of ssh2 to install
#
# === Examples
#
#  include php::extension::ssh2
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::extension::ssh2(
  $version  			= $php::extension::ssh2::params::version,
  $package  			= $php::extension::ssh2::params::package,
  $provider 			= $php::extension::ssh2::params::provider,
  $config_file    = $php::extension::ssh2::params::config_file,
  $config_changes = $php::extension::ssh2::params::config_changes
) inherits php::extension::ssh2::params {

  php::extension { 'ssh2':
    version  => $version,
    package  => $package,
    provider => $provider
  }

  php::config { 'php-extension-ssh2':
    config_file     => $config_file,
    config_changes  => $config_changes
  }

}
