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
# Christian "Jippi" Winther <jippignu@gmail.com>
# Tobias Nyholm <tobias@happyrecruiting.se>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#

class php::phpunit (
  $ensure   = $php::phpunit::params::ensure,
  $package  = $php::phpunit::params::package,
  $provider = $php::phpunit::params::provider
) inherits php::phpunit::params {

  package { $package:
    ensure    => $ensure,
    provider  => $provider;
  }

  Exec['php::pear::auto_discover'] -> Package[$package]

}
