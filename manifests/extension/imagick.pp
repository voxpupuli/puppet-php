# == Class: php::extension::imagick
#
# Install and configure the imagick PHP extension
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
#  include php::extension::imagick
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
class php::extension::imagick(
  $ensure   = $php::extension::imagick::params::ensure,
  $package  = $php::extension::imagick::params::package,
  $provider = $php::extension::imagick::params::provider,
  $inifile  = $php::extension::imagick::params::inifile,
  $settings = $php::extension::imagick::params::settings
) inherits php::extension::imagick::params {

  php::extension { 'imagick':
    ensure   => $ensure,
    package  => $package,
    provider => $provider
  }

  php::config { 'php-extension-imagick':
    file    => $inifile,
    config  => $settings
  }

}
