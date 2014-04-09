# == Class: php::extension::mongo
#
# Install the PHP mongo extension
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
#  include 'php::extension::mongo'
#
#  class {'php::extension::mongo':
#   ensure => latest
#  }
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
# Davide "SbiellONE" Bellettini <davide@bellettini.me>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
class php::extension::mongo(
  $ensure   = $php::extension::mongo::params::ensure,
  $package  = $php::extension::mongo::params::package,
  $provider = $php::extension::mongo::params::provider,
  $inifile  = $php::extension::mongo::params::inifile,
  $settings = $php::extension::mongo::params::settings
) inherits php::extension::mongo::params {

  php::extension { 'mongo':
    ensure   => $ensure,
    package  => $package,
    provider => $provider
  }

  php::config { 'php-extension-mongo':
    file    => $inifile,
    config  => $settings
  }
}
