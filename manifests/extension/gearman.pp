# == Class: php::extension::gearman
#
# Install the gearman PHP extension
#
# === Parameters
#
# [*ensure*]
#   The version of the package to install
#   Could be "latest", "installed" or a pinned version
#   This matches "ensure" from Package
#
# [*package*]
#   The package name in your provider
#
# [*provider*]
#   The provider used to install the package
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
	$ensure         = $php::extension::gearman::params::ensure,
  $package        = $php::extension::gearman::params::package,
  $provider       = $php::extension::gearman::params::provider,
  $config_file    = $php::extension::gearman::params::config_file,
  $config_changes = $php::extension::gearman::params::config_changes
) inherits php::extension::gearman::params {

	php::extension { 'gearman':
    ensure  => $ensure,
    package  => $package,
    provider => $provider
  }

  php::config { 'php-extension-gearman':
    config_file     => $config_file,
    config_changes  => $config_changes
  }

}
