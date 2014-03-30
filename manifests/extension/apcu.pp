# == Class: php::extension::apcu
#
# Install and configure the APCu PHP extension
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
#  include php::extension::apcu
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
class php::extension::apcu(
  $ensure   = $php::extension::apcu::params::ensure,
  $package  = $php::extension::apcu::params::package,
  $provider = $php::extension::apcu::params::provider,
  $inifile  = $php::extension::apcu::params::inifile,
  $settings = $php::extension::apcu::params::settings
) inherits php::extension::apcu::params {

  php::extension { 'apcu':
    ensure   => $ensure,
    package  => $package,
    provider => $provider
  }

  php::config { 'php-extension-apcu':
    file   => $inifile,
    config => $settings
  }

}
