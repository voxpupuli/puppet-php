# == Class: php::apache
#
# Install and configure mod_php for apache
#
# === Parameters
#
# [*ensure*]
#   The ensure of the apache package to install
#   Could be "latest", "installed" or a pinned verison
#
# [*package*]
#   The package name for apache package
#   For debian it's php5-apache
#
# [*provider*]
#   The provider used to install php5-apache
#   Could be "pecl", "apt" or any other OS package provider
#
# [*config_file*]
#   The path to the ini php5-apache ini file
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
#  include php::apache
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::apache(
  $ensure        = $php::apache::params::ensure,
  $package        = $php::apache::params::package,
  $provider       = $php::apache::params::provider,
  $config_file    = $php::apache::params::config_file,
  $config_changes = $php::apache::params::config_changes
) inherits php::apache::params {

  php::contrib::base_package { 'apache':
    ensure  => $ensure,
    provider => $provider;
  }

  package { $package:
    ensure   => $ensure,
    provider => $provider;
  }

  php::config { 'php-apache':
    config_file     => $config_file,
    config_changes  => $config_changes
  }

}
