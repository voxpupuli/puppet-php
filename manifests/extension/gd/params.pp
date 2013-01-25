# == Class: php::extension::gd::params
#
# Defaults file for gd extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*ensure*]
#   The ensure of gd to install
#   Could be "latest", "installed" or a pinned verison
#
# [*package*]
#   The package name for gd
#   For debian it's php5-gd
#
# [*provider*]
#   The provider used to install php5-gd
#   Could be "pecl", "apt" or any other OS package provider
#
# [*config_file*]
#   The path to the ini php5-gd ini file
#
# [*config_changes*]
#   Hash with 'set' nested hash of key => value
#   set changes to agues when applied to *config_file*
#
# === Examples
#
#  include 'php::extension::gd::package'
#
#  class {'php::extension::gd::package':
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
class php::extension::gd::params {

  $ensure        = $php::params::ensure
  $package        = 'php5-gd'
  $provider       = undef
  $config_file    = '/etc/php5/conf.d/20-gd.ini'
  $config_changes = {
    set => {

    }
  }

}
