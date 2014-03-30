# == Class: php::extension::apc::params
#
# Defaults file for the APC PHP extension
#
# === Parameters
#
# No parameters
#
# === Variables
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
# === Examples
#
# No examples
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
class php::extension::apc::params {

  $ensure   = $php::params::ensure
  $package  = $::lsbdistcodename ? {
    # php-apc is phased out as of Ubuntu 13.10 (saucy)
    # and Debian jessie in favour of php5-apcu
    # Debian
    'squeeze' => 'php-apc',
    'wheezy' => 'php-apc',

    # Ubuntu
    'lucid' => 'php-apc',
    'precise' => 'php-apc',
    'quantal' => 'php-apc',
    'raring' => 'php-apc',

    # Default to support future distros cleanly.
    default => 'php5-apcu',
  }
  $provider = undef
  $inifile  = "${php::params::config_root_ini}/apc.ini"
  $settings = [ ]

}
