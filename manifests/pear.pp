# == Class: php::pear
#
# Install PEAR package manager
#
# === Parameters
#
# [*version*]
#   The PHP version of PHP pear to install
#
# [*package*]
#   The package name for PHP pear
#   For debian it's php5-pear
#
# [*provider*]
#   The provider used to install php5-pear
#   Could be "pecl", "apt" or any other OS package provider
#
# === Variables
#
# No variables
#
# === Examples
#
#  include php::pear
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pear(
  $version  = $php::pear::params::version,
  $package  = $php::pear::params::package,
  $provider = $php::pear::params::provider
) inherits php::pear::params {

	package { $package:
    ensure	 => $version,
    provider => $provider;
  }

}
