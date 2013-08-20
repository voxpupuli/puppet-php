# == Class: php::extension::intl
#
# Install the Intl PHP extension
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
#  include php::extension::intl
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::extension::intl(
  $ensure   = $php::extension::intl::params::ensure,
  $package  = $php::extension::intl::params::package,
  $provider = $php::extension::intl::params::provider,
  $inifile  = $php::extension::intl::params::inifile,
  $settings = $php::extension::intl::params::settings
) inherits php::extension::intl::params {

  php::extension { 'intl':
    ensure   => $ensure,
    package  => $package,
    provider => $provider
  }

  php::config { 'php-extension-intl':
    inifile  => $inifile,
    settings => $settings
  }

}
