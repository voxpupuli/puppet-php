# == Class: php::extension::apc
#
# Install and configure the APC PHP extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*version*]
#   The version of APC to install
#   Could be "latest", "installed" or a pinned verison
#
# [*package*]
#   The package name for apc
#   For debian it's php5-apc
#
# [*provider*]
#   The provider used to install php5-apc
#   Could be "pecl", "apt" or any other OS package provider
#
# [*config_file*]
#   The path to the ini php5-apc ini file
#
# [*config_changes*]
#   Hash with 'set' nested hash of key => value
#   set changes to agues when applied to *config_file*
#
# === Examples
#
#  include php::extension::apc
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::extension::apc(
  $version        = $php::params::version,
  $package        = $php::extension::apc::params::package,
  $provider       = $php::extension::apc::params::provider,
  $config_file    = $php::extension::apc::params::config_file,
  $config_changes = $php::extension::apc::params::config_changes
) inherits php::extension::apc::params {

  php::extension { 'apc':
    version  => $version,
    package  => $package,
    provider => $provider
  }

  php::config { 'php-extension-apc':
    config_file    => $config_file,
    config_changes => $config_changes
  }

}
