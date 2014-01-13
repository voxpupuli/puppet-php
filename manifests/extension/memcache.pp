# == Class: php::extension::memcache
#
# Install and configure the Memcache PHP extension
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
#  include php::extension::memcache
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
class php::extension::memcache(
  $ensure   = $php::extension::memcache::params::ensure,
  $package  = $php::extension::memcache::params::package,
  $provider = $php::extension::memcache::params::provider,
  $inifile  = $php::extension::memcache::params::inifile,
  $settings = $php::extension::memcache::params::settings
) inherits php::extension::memcache::params {

  php::extension { 'memcache':
    ensure   => $ensure,
    package  => $package,
    provider => $provider
  }

  php::config { 'php-extension-memcache':
    inifile  => $inifile,
    settings => $settings
  }

}
