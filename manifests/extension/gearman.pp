# == Class: php::extension::gearman
#
# Install the gearman PHP extension
#
# === Parameters
#
# [*version*]
#   The version of gearman to install
#   Could be "latest", "installed" or a pinned verison
#
# [*package*]
#   The package name for gearman
#   For debian it's php5-gearman
#
# [*provider*]
#   The provider used to install php5-gearman
#   Could be "pecl", "apt" or any other OS package provider
#
# [*config_file*]
#   The path to the ini php5-gearman ini file
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
#  include php::extension::gearman
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::extension::gearman(
	$version        = $php::extension::gearman::params::version,
  $package        = $php::extension::gearman::params::package,
  $provider       = $php::extension::gearman::params::provider,
  $config_file    = $php::extension::gearman::params::config_file,
  $config_changes = $php::extension::gearman::params::config_changes
) inherits php::extension::gearman::params {

	php::extension { 'gearman':
    version  => $version,
    package  => $package,
    provider => $provider
  }

  php::config { 'php-extension-gearman':
    config_file     => $config_file,
    config_changes  => $config_changes
  }

}
