# == Class: php::extension::http::params
#
# Defaults file for the http PHP extension
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
# [*config_file*]
#   The path to the extension ini file
#
# [*config_changes*]
#   Hash with 'set' nested hash of key => value
#   set changes to agues when applied to *config_file*
#
# [*required_packages*]
#   Packages to install before the extension can be compiled
#
# === Examples
#
# No examples
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::extension::http::params {

  $ensure         = $php::params::ensure
  $package        = 'pecl_http'
  $provider       = 'pecl'
  $config_file    = '/etc/php5/conf.d/http.ini'
  $config_changes = {
    set => {
     '.anon/extension' => 'http.so'
    }
  }

  $required_packages = [
    'libcurl4-openssl-dev',
    'libmagick++-dev'
  ]

}
