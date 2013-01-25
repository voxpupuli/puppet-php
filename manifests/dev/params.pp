# == Class: php::dev::params
#
# Defaults file for dev package
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*version*]
#   The version of the dev package to install
#   Could be "latest", "installed" or a pinned verison
#
# [*package*]
#   The package name for dev package
#   For debian it's php5-dev
#
# [*provider*]
#   The provider used to install php5-dev
#   Could be "pecl", "apt" or any other OS package provider
#
# [*config_file*]
#   The path to the ini php5-dev ini file
#
# [*config_changes*]
#   Hash with 'set' nested hash of key => value
#   set changes to agues when applied to *config_file*
#
# === Examples
#
#  include 'php::dev::package'
#
#  class {'php::dev::package
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
class php::dev::params {

  $version  = $php::params::version
  $package  = 'php5-dev'
  $provider	= undef

}
