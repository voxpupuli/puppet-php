# == Class: php::extension::opcache
#
# Install the opcache PHP extension
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
#  include php::extension::opcache
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
class php::extension::opcache(
  $ensure   = $php::extension::opcache::params::ensure,
  $package  = $php::extension::opcache::params::package,
  $provider = $php::extension::opcache::params::provider,
  $inifile  = $php::extension::opcache::params::inifile,
  $settings = $php::extension::opcache::params::settings
) inherits php::extension::opcache::params {

  if $package {
    php::extension { 'opcache':
      ensure   => $ensure,
      package  => $package,
      provider => $provider
    }
  }

  php::config { 'php-extension-opcache':
    file    => $inifile,
    config  => $settings
  }

}
