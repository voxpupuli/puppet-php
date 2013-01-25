# == Class: php::extension::ssh2
#
# Install and configure the ssh2 PHP extension
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
  $ensure  			  = $php::extension::ssh2::params::ensure,
  $package  			= $php::extension::ssh2::params::package,
  $provider 			= $php::extension::ssh2::params::provider,
  $config_file    = $php::extension::ssh2::params::config_file,
  $config_changes = $php::extension::ssh2::params::config_changes
) inherits php::extension::ssh2::params {

  php::extension { 'ssh2':
    ensure  => $ensure,
    package  => $package,
    provider => $provider
  }

  php::config { 'php-extension-ssh2':
    config_file     => $config_file,
    config_changes  => $config_changes
  }

}
