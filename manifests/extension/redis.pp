# == Class: php::extension::redis
#
# Install and configure the redis PHP extension
#
# === Parameters
#
# [*ensure*]
#   The version of the package to install
#   Could be "latest", "installed" or a pinned version
#   This matches "ensure" from Package
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
#  include php::extension::redis
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
class php::extension::redis(
  $ensure   = $php::extension::redis::params::ensure,
  $package  = $php::extension::redis::params::package,
  $provider = $php::extension::redis::params::provider,
  $inifile  = $php::extension::redis::params::inifile,
  $settings = $php::extension::redis::params::settings
) inherits php::extension::redis::params {

  php::extension { 'redis':
    ensure   => $ensure,
    package  => $package,
    provider => $provider
  }

  php::config { 'php-extension-redis':
    file    => $inifile,
    config  => $settings
  }

}
