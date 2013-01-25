# == Class: php::extension::gearman::params
#
# Defaults file for gearman extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*ensure*]
#   The ensure of gearman to install
#   Could be "latest", "installed" or a pinned verison
#
# [*package*]
#   The package name for gearman
#   For debian it's php5-gearman
#
# [*provider*]
#   The provider used to install php5-gearman
#   Could be "pecl", "apt" or any other OS package provider
#
# [*config_file*]
#   The path to the ini php5-gearman ini file
#
# [*config_changes*]
#   Hash with 'set' nested hash of key => value
#   set changes to agues when applied to *config_file*
#
# === Examples
#
#  include 'php::extension::gearman::package'
#
#  class {'php::extension::gearman::package':
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
class php::extension::gearman::params {

  $ensure        = $php::params::ensure
  $package        = 'php5-gearman'
  $provider       = undef
  $config_file    = '/etc/php5/conf.d/20-gearman.ini'
  $config_changes = {
    set => {

    }
  }

}
