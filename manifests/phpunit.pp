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
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
class php::phpunit {

  package { 'pear.phpunit.de/PHPUnit':
    ensure    => '3.7.21',
    provider  => pear;
  }

  Exec['php::pear::auto_discover'] -> Package['pear.phpunit.de/PHPUnit']

}
