# == Class: php::pecl::ssh2::params
#
# Defaults file for ssh2 extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*version*]
#   The version of ssh2 to install
#   Could be "latest", "installed" or a pinned verison
#
# [*package*]
#   The package name for ssh2
#   For debian it's php5-ssh2
#
# [*provider*]
#   The provider used to install php5-ssh2
#   Could be "pecl", "apt" or any other OS package provider
#
# [*config_file*]
#   The path to the ini php5-ssh2 ini file
#
# [*config_changes*]
#   Hash with 'set' nested hash of key => value
#   set changes to agues when applied to *config_file*
#
# === Examples
#
#  include 'php::pecl::ssh2::package'
#
#  class {'php::pecl::ssh2::package':
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
class php::pecl::ssh2::params {

  $version        = $php::params::version
  $package        = 'php5-ssh2'
  $provider       = undef
  $config_file    = '/etc/php5/conf.d/20-ssh2.ini'
  $config_changes = {
    set => {

	}
  }

}
