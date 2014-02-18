# == Class: php::extension::memcached
#
# Install and configure the Memcached PHP extension
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
#  include php::extension::memcached
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
# Nathan Sullivan <nmsullivan@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
class php::extension::memcached(
  $ensure   = $php::extension::memcached::params::ensure,
  $package  = $php::extension::memcached::params::package,
  $provider = $php::extension::memcached::params::provider,
  $inifile  = $php::extension::memcached::params::inifile,
  $settings = $php::extension::memcached::params::settings
) inherits php::extension::memcached::params {

  php::extension { 'memcached':
    ensure   => $ensure,
    package  => $package,
    provider => $provider
  }

  php::config { 'php-extension-memcached':
    inifile  => $inifile,
    settings => $settings
  }

}
