# == Class: php::extension::ldap
#
# Install and configure the ldap PHP extension
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
#  include php::extension::ldap
#
# === Authors
#
# Arthur Andersen <leoc.git@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::extension::ldap(
  $ensure   = $php::extension::ldap::params::ensure,
  $package  = $php::extension::ldap::params::package,
  $provider = $php::extension::ldap::params::provider,
  $inifile  = $php::extension::ldap::params::inifile,
  $settings = $php::extension::ldap::params::settings,
) inherits php::extension::ldap::params {

  php::extension { 'ldap':
    ensure   => $ensure,
    package  => $package,
    provider => $provider
  }

  php::config { 'php-extension-ldap':
    file    => $inifile,
    config  => $settings
  }
}
