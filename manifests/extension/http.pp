# == Class: php::extension::http
#
# Install the http PHP extension
#
# === Parameters
#
# [*version*]
#   The version of http to install
#   Could be "latest", "installed" or a pinned verison
#
# [*package*]
#   The package name for http
#   For debian it's pecl_http
#
# [*provider*]
#   The provider used to install php5-http
#   Could be "pecl", "apt" or any other OS package provider
#
# [*config_file*]
#   The path to the ini php5-http ini file
#
# [*config_changes*]
# Hash with 'set' nested hash of key => value
# set changes to agues when applied to *config_file*
#
# === Variables
#
# No variables
#
# === Examples
#
#  include php::extension::http
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::extension::http(
	$version  			= $php::extension::http::params::version,
  $package  			= $php::extension::http::params::package,
  $provider 			= $php::extension::http::params::provider,
  $config_file  	= $php::extension::http::params::config_file,
  $config_changes = $php::extension::http::params::config_changes
) inherits php::extension::http::params {

  package { $required_packages:
  	ensure => installed;
  }

  php::extension { 'http':
    version  => $version,
    package  => $package,
    provider => $provider,
    require	 => Package[$required_packages]
  }

 php::config { 'php-extension-http':
    config_file     => $config_file,
    config_changes  => $config_changes
  }

}
