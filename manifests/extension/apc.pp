# == Class: php::extension::apc
#
# Install and configure the APC PHP extension
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
# [*inifile*]
#   The path to the extension ini file
#
# [*settings*]
#   Hash with 'set' nested hash of key => value
#   set changes to agues when applied to *inifile*
#
# === Variables
#
# No variables
#
# === Examples
#
#  include php::extension::apc
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
class php::extension::apc(
  $ensure   = $php::extension::apc::params::ensure,
  $package  = $php::extension::apc::params::package,
  $provider = $php::extension::apc::params::provider,
  $inifile  = $php::extension::apc::params::inifile,
  $settings = $php::extension::apc::params::settings
) inherits php::extension::apc::params {

  php::extension { 'apc':
    ensure   => $ensure,
    package  => $package,
    provider => $provider
  }

  php::config { 'php-extension-apc':
    inifile  => $inifile,
    settings => $settings
  }

}
