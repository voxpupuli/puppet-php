# == Class: php::extension::mysqlnd
#
# Install and configure the mysqlnd PHP extension
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
#  include php::extension::mysqlnd
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
class php::extension::mysqlnd(
  $ensure   = $php::extension::mysqlnd::params::ensure,
  $package  = $php::extension::mysqlnd::params::package,
  $provider = $php::extension::mysqlnd::params::provider,
  $inifile  = $php::extension::mysqlnd::params::inifile,
  $settings = $php::extension::mysqlnd::params::settings,
) inherits php::extension::mysqlnd::params {

  php::extension { 'mysqlnd':
    ensure   => $ensure,
    package  => $package,
    provider => $provider
  }

  php::config { 'php-extension-mysqlnd':
    inifile   => $inifile,
    settings  => $settings
  }

}
