# == Class: php::extension::ssh2
#
# Install and configure the ssh2 PHP extension
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
#  include php::extension::ssh2
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
class php::extension::ssh2(
  $ensure   = $php::extension::ssh2::params::ensure,
  $package  = $php::extension::ssh2::params::package,
  $provider = $php::extension::ssh2::params::provider,
  $inifile  = $php::extension::ssh2::params::inifile,
  $settings = $php::extension::ssh2::params::settings
) inherits php::extension::ssh2::params {

  php::extension { 'ssh2':
    ensure   => $ensure,
    package  => $package,
    provider => $provider
  }

  php::config { 'php-extension-ssh2':
    inifile  => $inifile,
    settings => $settings
  }

}
