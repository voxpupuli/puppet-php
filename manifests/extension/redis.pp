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
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::extension::redis(
  $ensure   = 'master',
  $inifile  = $php::extension::redis::params::inifile,
  $settings = $php::extension::redis::params::settings
) {
  include php::extension::redis::params

  class { 'php::extension::redis::package':
    ensure => $ensure
  }

  php::config { 'php-extension-redis':
    inifile  => $inifile,
    settings => $settings
  }

}
