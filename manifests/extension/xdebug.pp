# == Class: php::extension::xdebug
#
# Install and configure the xdebug PHP extension
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
#  include php::extension::xdebug
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
class php::extension::xdebug (
  $ensure   = $php::extension::xdebug::params::ensure,
  $package  = $php::extension::xdebug::params::package,
  $provider = $php::extension::xdebug::params::provider,
  $inifile  = $php::extension::xdebug::params::inifile,
  $settings = $php::extension::xdebug::params::settings
) inherits php::extension::xdebug::params {

  php::extension { 'xdebug':
    ensure   => $ensure,
    package  => $package,
    provider => $provider
  }

  php::config { 'php-extension-xdebug':
    inifile  => $inifile,
    settings => $settings
  }

}
