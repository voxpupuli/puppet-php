# == Class: php::extension::gd
#
# Install the gd PHP extension
#
# === Parameters
#
# [*version*]
#   The version of gd to install
#   Could be "latest", "installed" or a pinned verison
#
# [*package*]
#   The package name for gd
#   For debian it's php5-gd
#
# [*provider*]
#   The provider used to install php5-gd
#   Could be "pecl", "apt" or any other OS package provider
#
# [*config_file*]
#   The path to the ini php5-gd ini file
#
# [*config_changes*]
# Hash with 'set' nested hash of key => value
# set changes to agues when applied to *config_file*
#
# === Variables
#
# No variables
#
# === Examples
#
#  include php::extension::gd
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::extension::gd(
  $version        = $php::extension::gd::params::version,
  $package        = $php::extension::gd::params::package,
  $provider       = $php::extension::gd::params::provider,
  $config_file    = $php::extension::gd::params::config_file,
  $config_changes = $php::extension::gd::params::config_changes
) inherits php::extension::gd::params {

  php::extension { 'gd':
    version  => $version,
    package  => $package,
    provider => $provider
  }

  php::config { 'php-extension-gd':
    config_file    => $config_file,
    config_changes => $config_changes
  }

}
