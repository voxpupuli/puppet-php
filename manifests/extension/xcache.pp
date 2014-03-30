# == Class: php::extension::xcache
#
# Install and configure the Xcache PHP extension
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
#  include php::extension::xcache
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
class php::extension::xcache(
  $ensure   = $php::extension::xcache::params::ensure,
  $package  = $php::extension::xcache::params::package,
  $provider = $php::extension::xcache::params::provider,
  $inifile  = $php::extension::xcache::params::inifile,
  $settings = $php::extension::xcache::params::settings
) inherits php::extension::xcache::params {

  php::extension { 'xcache':
    ensure   => $ensure,
    package  => $package,
    provider => $provider
  }

  php::config { 'php-extension-xcache':
    file    => $inifile,
    config  => $settings
  }

}
