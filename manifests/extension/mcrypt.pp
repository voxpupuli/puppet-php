# == Class: php::extension::mcrypt
#
# Install and configure the mcrypt PHP extension
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
#  include php::extension::mcrypt
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
class php::extension::mcrypt(
  $ensure   = $php::extension::mcrypt::params::ensure,
  $package  = $php::extension::mcrypt::params::package,
  $provider = $php::extension::mcrypt::params::provider,
  $inifile  = $php::extension::mcrypt::params::inifile,
  $settings = $php::extension::mcrypt::params::settings
) inherits php::extension::mcrypt::params {

  php::extension { 'mcrypt':
    ensure   => $ensure,
    package  => $package,
    provider => $provider
  }

  php::config { 'php-extension-mcrypt':
    file    => $inifile,
    config  => $settings
  }

}
