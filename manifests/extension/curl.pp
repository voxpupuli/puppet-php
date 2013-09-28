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
#  include php::extension::curl
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
class php::extension::curl(
  $ensure   = $php::extension::curl::params::ensure,
  $package  = $php::extension::curl::params::package,
  $provider = $php::extension::curl::params::provider,
  $inifile  = $php::extension::curl::params::inifile,
  $settings = $php::extension::curl::params::settings
) inherits php::extension::curl::params {

  php::extension { 'curl':
    ensure   => $ensure,
    package  => $package,
    provider => $provider
  }

  php::config { 'php-extension-curl':
    file    => $inifile,
    config  => $settings
  }

}
