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
class php::phpunit {

  package { 'pear.phpunit.de/PHPUnit':
    ensure   	=> '3.7.12',
    provider 	=> pear,
    before		=> Exec['php::pear::auto_discover'];
  }

}
