# == Class: php::extension::uploadprogress
#
# Install the PHP uploadprogress extension
#
# === Parameters
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
# 	Hash with 'set' nested hash of key => value
# 	set changes to agues when applied to *config_file*
#
# === Variables
#
# No variables
#
# === Examples
#
#  include 'php::extension::uploadprogress'
#
#  class {'php::extension::uploadprogress':
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
class php::extension::uploadprogress(
  $version  			= $php::extension::uploadprogress::params::version,
  $package  			= $php::extension::uploadprogress::params,
  $provider 			= $php::extension::uploadprogress::params::provider,
  $config_file    = $php::extension::uploadprogress::params::config_file,
  $config_changes = $php::extension::uploadprogress::params::config_changes
) inherits php::extension::uploadprogress::params {

  php::extension { 'uploadprogress':
    version  => $version,
    package  => $package,
    provider => $provider
  }

  php::config { 'php-extension-uploadprogress':
    config_file     => $config_file,
    config_changes  => $config_changes
  }

}
