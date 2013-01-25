# == Class: php::extension::http
#
# Install the http PHP extension
#
# === Parameters
#
# [*ensure*]
#   The version of the package to install
#   Could be "latest", "installed" or a pinned version
#   This matches "ensure" from Package
#
# [*package*]
#   The package name in your provider
#
# [*provider*]
#   The provider used to install the package
#
# [*config_file*]
#   The path to the extension ini file
#
# [*config_changes*]
#   Hash with 'set' nested hash of key => value
#   set changes to agues when applied to *config_file*
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
	$ensure  			  = $php::extension::http::params::ensure,
  $package  			= $php::extension::http::params::package,
  $provider 			= $php::extension::http::params::provider,
  $config_file  	= $php::extension::http::params::config_file,
  $config_changes = $php::extension::http::params::config_changes
) inherits php::extension::http::params {

  package { $required_packages:
  	ensure => installed;
  }

  php::extension { 'http':
    ensure  => $ensure,
    package  => $package,
    provider => $provider,
    require	 => Package[$required_packages]
  }

 php::config { 'php-extension-http':
    config_file     => $config_file,
    config_changes  => $config_changes
  }

}
