# == Class: php::extension::igbinary
#
# Install and configure the igbinary PHP extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*version*]
#   The version of igbinary to install
#   Could be "latest", "installed" or a pinned verison
#
# [*package*]
#   The package name for igbinary
#   For debian it's php5-igbinary
#
# [*provider*]
#   The provider used to install php5-igbinary
#   Could be "pecl", "apt" or any other OS package provider
#
# [*config_file*]
#   The path to the ini php5-igbinary ini file
#
# [*config_changes*]
# 	Hash with 'set' nested hash of key => value
# 	set changes to agues when applied to *config_file*
#
# === Examples
#
#  include php::extension::igbinary
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::extension::igbinary(
	$version  			= $php::extension::igbinary::params::version,
  $package  			= $php::extension::igbinary::params::package,
  $provider 			= $php::extension::igbinary::params::provider,
  $config_file    = $php::extension::igbinary::params::config_file,
  $config_changes = $php::extension::igbinary::params::config_changes
) inherits php::extension::igbinary::params {

  php::extension { 'igbinary':
    version  => $version,
    package  => $package,
    provider => $provider
  }

  php::config { 'php-extension-igbinary':
    config_file     => $config_file,
    config_changes  => $config_changes
  }

}
