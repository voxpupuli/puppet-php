# == Class: php::cli::package
#
# PHP CLI package
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*version*]
#   The PHP version of PHP CLI to install
#
# [*package*]
#   The package name for PHP CLI
#   For debian it's php5-cli
#
# [*provider*]
#   The provider used to install php5-cli
#   Could be "pecl", "apt" or any other OS package provider
#
# === Examples
#
#  include php::cli::package
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::cli::package(
  $version  = $php::cli::params::version,
  $package  = $php::cli::params::package,
  $provider = $php::cli::params::provider
) inherits php::cli::params {

  php::contrib::base_package { 'cli':
  	version  => $version,
  	provider => $provider;
  }

  package { $package:
    ensure	 => $version,
    provider => $provider;
  }

}
