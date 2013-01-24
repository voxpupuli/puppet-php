# == Class: php::pecl::curl::params
#
# Defaults file for curl extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*version*]
#   The version of curl to install
#   Could be "latest", "installed" or a pinned verison
#
# [*package*]
#   The package name for curl
#   For debian it's php5-curl
#
# [*provider*]
#   The provider used to install php5-curl
#   Could be "pecl", "apt" or any other OS package provider
#
# [*config_file*]
#   The path to the ini php5-curl ini file
#
# [*config_changes*]
#   Hash with 'set' nested hash of key => value
#   set changes to agues when applied to *config_file*
#
# === Examples
#
#  include 'php::pecl::curl::package'
#
#  class {'php::pecl::curl::package':
#   version => latest
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
class php::pecl::curl::params {

  $version        = $php::params::version
  $package        = 'php5-curl'
  $provider       = undef
  $config_file    = '/etc/php5/conf.d/20-curl.ini'
  $config_changes = {
    set => {

    }
  }

}
