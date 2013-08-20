# == Class: php::extension::igbinary
#
# Install and configure the igbinary PHP extension
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
#  include php::extension::igbinary
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
class php::extension::igbinary(
  $ensure   = $php::extension::igbinary::params::ensure,
  $package  = $php::extension::igbinary::params::package,
  $provider = $php::extension::igbinary::params::provider,
  $inifile  = $php::extension::igbinary::params::inifile,
  $settings = $php::extension::igbinary::params::settings
) inherits php::extension::igbinary::params {

  php::extension { 'igbinary':
    ensure   => $ensure,
    package  => $package,
    provider => $provider
  }

  php::config { 'php-extension-igbinary':
    inifile   => $inifile,
    settings  => $settings
  }

}
