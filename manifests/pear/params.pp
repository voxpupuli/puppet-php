# == Class: php::pear::params
#
# Defaults file for pear package
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*version*]
#   The version of the pear package to install
#   Could be "latest", "installed" or a pinned verison
#
# [*package*]
#   The package name for pear package
#   For debian it's php5-pear
#
# [*provider*]
#   The provider used to install php5-pear
#   Could be "pecl", "apt" or any other OS package provider
#
# [*config_file*]
#   The path to the ini php5-pear ini file
#
# [*config_changes*]
#   Hash with 'set' nested hash of key => value
#   set changes to agues when applied to *config_file*
#
# === Examples
#
#  include 'php::pear::package'
#
#  class {'php::pear::package
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
class php::pear::params {

  $version        = $php::params::version
  $package        = ['php-pear']
  $provider       = undef

}
