# == Class: php::cli::package
#
# PHP CLI package
#
# Will install PHP cli
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
class php::cli::package {

  package {
    'php5-cli':
      ensure => $::php_version;
    'php5':
      ensure  => $::php_version;
  }

  Apt::Source['dotdeb'] ~> Exec['apt_update'] -> Package['php5-cli']
  Apt::Source['dotdeb'] ~> Exec['apt_update'] -> Package['php5']

}
