# == Class: php::extension::http
#
# Install the http PHP extension
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
#  include php::extension::http
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
class php::extension::http(
  $ensure   = $php::extension::http::params::ensure,
  $package  = $php::extension::http::params::package,
  $provider = $php::extension::http::params::provider,
  $inifile  = $php::extension::http::params::inifile,
  $settings = $php::extension::http::params::settings
) inherits php::extension::http::params {

  php::extension { 'http':
    ensure   => $ensure,
    package  => $package,
    provider => $provider;
  }

  php::config { 'php-extension-http':
    inifile  => $inifile,
    settings => $settings;
  }

}
