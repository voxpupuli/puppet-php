# == Class: php::apache::package
#
# PHP apache package
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*version*]
#   The PHP version of PHP apache to install
#
# [*package*]
#   The package name for PHP apache
#   For debian it's php5-apache
#
# [*provider*]
#   The provider used to install php5-apache
#   Could be "pecl", "apt" or any other OS package provider
#
# === Examples
#
#  include php::apache::package
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::apache::package(
  $version  = $php::apache::params::version,
  $package  = $php::apache::params::package,
  $provider = $php::apache::params::provider
) inherits php::apache::params {

  php::contrib::base_package { 'apache':
  	version  => $version,
  	provider => $provider;
  }

  package { $package:
    ensure	 => $version,
    provider => $provider;
  }

}
