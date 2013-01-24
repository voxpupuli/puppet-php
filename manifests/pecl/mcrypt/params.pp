# == Class: php::pecl::mcrypt::params
#
# Defaults file for mcrypt extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*version*]
#   The version of mcrypt to install
#   Could be "latest", "installed" or a pinned verison
#
# [*package*]
#   The package name for mcrypt
#   For debian it's php5-mcrypt
#
# [*provider*]
#   The provider used to install php5-mcrypt
#   Could be "pecl", "apt" or any other OS package provider
#
# [*config_file*]
#   The path to the ini php5-mcrypt ini file
#
# [*config_changes*]
#   Hash with 'set' nested hash of key => value
#   set changes to agues when applied to *config_file*
#
# === Examples
#
#  include 'php::pecl::mcrypt::package'
#
#  class {'php::pecl::mcrypt::package':
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
class php::pecl::mcrypt::params {

  $version        = $php::params::version
  $package        = 'php5-mcrypt'
  $provider       = undef
  $config_file    = '/etc/php5/conf.d/20-mcrypt.ini'
  $config_changes = {
    set => {

    }
  }

}
