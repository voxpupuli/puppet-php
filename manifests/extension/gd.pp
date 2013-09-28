# == Class: php::extension::gd
#
# Install the gd PHP extension
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
#  include php::extension::gd
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
class php::extension::gd(
  $ensure   = $php::extension::gd::params::ensure,
  $package  = $php::extension::gd::params::package,
  $provider = $php::extension::gd::params::provider,
  $inifile  = $php::extension::gd::params::inifile,
  $settings = $php::extension::gd::params::settings
) inherits php::extension::gd::params {

  php::extension { 'gd':
    ensure   => $ensure,
    package  => $package,
    provider => $provider
  }

  php::config { 'php-extension-gd':
    file    => $inifile,
    config  => $settings
  }

}
