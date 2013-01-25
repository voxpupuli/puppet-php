# == Class: php::extension::curl
#
# Install the curl PHP extension
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
#  include php::extension::curl
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::extension::curl(
  $ensure         = $php::extension::curl::params::ensure,
  $package        = $php::extension::curl::params::package,
  $provider       = $php::extension::curl::params::provider,
  $config_file    = $php::extension::curl::params::config_file,
  $config_changes = $php::extension::curl::params::config_changes
) inherits php::extension::curl::params {

  php::extension { 'curl':
    ensure  => $ensure,
    package  => $package,
    provider => $provider
  }

  php::config { 'php-extension-curl':
    config_file     => $config_file,
    config_changes  => $config_changes
  }

}
