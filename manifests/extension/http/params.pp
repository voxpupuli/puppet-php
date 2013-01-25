# == Class: php::extension::http::params
#
# Defaults file for http extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*ensure*]
#   The ensure of http to install
#   Could be "latest", "installed" or a pinned verison
#
# [*package*]
#   The package name for http
#   For debian it's http
#
# [*provider*]
#   The provider used to install php5-http
#   Could be "pecl", "apt" or any other OS package provider
#
# [*config_file*]
#   The path to the ini php5-http ini file
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
#  include 'php::extension::http::package'
#
#  class {'php::extension::http::package':
#   ensure => latest
#  }
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

  $ensure        = $php::params::ensure
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
