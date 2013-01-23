# == Class: php::pear::package
#
# PHP pear package
#
# Install pear package manager
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*php_version*]
#   The PHP version of PHP cli to install
#
# === Examples
#
#  include php::pear::package
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pear::package {

  package { 'php-pear':
    ensure => $::php_version;
  }

  Apt::Source['dotdeb']
    ~> Exec['apt_update']
    -> Package['php-pear']

}
