# == Class: php::dev::package
#
# PHP dev package
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*version*]
#   The PHP version of PHP dev to install
#
# [*package*]
#   The package name for PHP dev
#   For debian it's php5-dev
#
# [*provider*]
#   The provider used to install php5-dev
#   Could be "pecl", "apt" or any other OS package provider
#
# === Examples
#
#  include php::dev::package
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::dev::package(
  $version  = $php::dev::params::version,
  $package  = $php::dev::params::package,
  $provider = $php::dev::params::provider
) inherits php::dev::params {

  package { $package:
    ensure	 => $version,
    provider => $provider;
  }

}
