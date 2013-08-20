# == Class: php::extension::uploadprogress
#
# Install the PHP uploadprogress extension
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
#  include 'php::extension::uploadprogress'
#
#  class {'php::extension::uploadprogress':
#   ensure => latest
#  }
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
class php::extension::uploadprogress(
  $ensure   = $php::extension::uploadprogress::params::ensure,
  $package  = $php::extension::uploadprogress::params,
  $provider = $php::extension::uploadprogress::params::provider,
  $inifile  = $php::extension::uploadprogress::params::inifile,
  $settings = $php::extension::uploadprogress::params::settings
) inherits php::extension::uploadprogress::params {

  php::extension { 'uploadprogress':
    ensure   => $ensure,
    package  => $package,
    provider => $provider
  }

  php::config { 'php-extension-uploadprogress':
    inifile   => $inifile,
    settings  => $settings
  }

}
