# == Class: php::extension::mysql::params
#
# Defaults file for mysql extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*version*]
#   The version of mysql to install
#   Could be "latest", "installed" or a pinned verison
#
# [*package*]
#   The package name for mysql
#   For debian it's php5-mysql
#
# [*provider*]
#   The provider used to install php5-mysql
#   Could be "pecl", "apt" or any other OS package provider
#
# [*config_file*]
#   The path to the ini php5-mysql ini file
#
# [*config_changes*]
#   Hash with 'set' nested hash of key => value
#   set changes to agues when applied to *config_file*
#
# === Examples
#
#  include 'php::extension::mysql::package'
#
#  class {'php::extension::mysql::package':
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
class php::extension::mysql::params {

  $version        = $php::params::version
  $package        = 'php5-mysql'
  $provider       = undef
  $config_file    = '/etc/php5/conf.d/20-mysql.ini'
  $config_changes = {
    set => {

    }
  }

}
