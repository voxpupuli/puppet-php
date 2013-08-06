# == Class: php::phpunit
#
# Install phpunit, PHP testing framework
#
# === Parameters
#
# No parameters
#
# === Variables
#
# No variables
#
# === Examples
#
#  include php::phpunit
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::phpunit ss php::pear(
  $ensure   = $php::phpunit::params::ensure,
  $package  = $php::phpunit::params::package,
  $provider = $php::phpunit::params::provider
) inherits php::pear::params {

  package { $package:
    ensure    => $ensure,
    provider  => $provider;
  }

  Exec['php::pear::auto_discover'] -> Package[$package]

}
