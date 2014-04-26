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

#FIXME: no pear
class php::phpunit (
  $package  = 'pear.phpunit.de/PHPUnit',
  $provider = 'pear'
) {

  package { $package:
    ensure    => present,
    provider  => $provider;
  }

  Exec['php::pear::auto_discover'] -> Package[$package]
}
