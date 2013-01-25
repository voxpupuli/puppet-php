# == Class: php::extension::uploadprogress::params
#
# Defaults file for uploadprogress extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*version*]
#   The version of uploadprogress to install
#   Could be "latest", "installed" or a pinned verison
#
# [*package*]
#   The package name for uploadprogress
#   For debian it's php5-uploadprogress
#
# [*provider*]
#   The provider used to install php5-uploadprogress
#   Could be "pecl", "apt" or any other OS package provider
#
# [*config_file*]
#   The path to the ini php5-uploadprogress ini file
#
# [*config_changes*]
#   Hash with 'set' nested hash of key => value
#   set changes to agues when applied to *config_file*
#
# === Examples
#
#  include 'php::extension::uploadprogress::package'
#
#  class {'php::extension::uploadprogress::package':
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
class php::extension::uploadprogress::params {

  $version        = $php::params::version
  $package        = 'uploadprogress'
  $provider       = 'pecl'
  $config_file    = '/etc/php5/conf.d/uploadprogress.ini'
  $config_changes = {
    set => {
      '.anon/extension' => 'uploadprogress.so'
    }
  }

}
