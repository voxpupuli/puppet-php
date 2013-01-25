# == Class: php::extension::imagick::params
#
# Defaults file for imagick extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*version*]
#   The version of imagick to install
#   Could be "latest", "installed" or a pinned verison
#
# [*package*]
#   The package name for imagick
#   For debian it's php5-imagick
#
# [*provider*]
#   The provider used to install php5-imagick
#   Could be "pecl", "apt" or any other OS package provider
#
# [*config_file*]
#   The path to the ini php5-imagick ini file
#
# [*config_changes*]
#   Hash with 'set' nested hash of key => value
#   set changes to agues when applied to *config_file*
#
# === Examples
#
#  include 'php::extension::imagick::package'
#
#  class {'php::extension::imagick::package':
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
class php::extension::imagick::params {

  $version        = $php::params::version
  $package        = 'php5-imagick'
  $provider       = undef
  $config_file    = '/etc/php5/conf.d/20-imagick.ini'
  $config_changes = {
    set => {

    }
  }

}
