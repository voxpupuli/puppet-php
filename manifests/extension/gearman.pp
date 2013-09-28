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
#  include php::extension::gearman
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
class php::extension::gearman(
  $ensure   = $php::extension::gearman::params::ensure,
  $package  = $php::extension::gearman::params::package,
  $provider = $php::extension::gearman::params::provider,
  $inifile  = $php::extension::gearman::params::inifile,
  $settings = $php::extension::gearman::params::settings
) inherits php::extension::gearman::params {

  php::extension { 'gearman':
    ensure   => $ensure,
    package  => $package,
    provider => $provider
  }

  php::config { 'php-extension-gearman':
    file    => $inifile,
    config  => $settings
  }

}
