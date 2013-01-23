# == Class: php::pecl::mysql::package
#
# Install the PHP mysql extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*php_version*]
#   The version of mysql to install
#
# === Examples
#
#  include php::pecl::mysql::package
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::mysql::package {

  package { 'php5-mysql':
    ensure => $::php_version;
  }

  Apt::Source['dotdeb']
    ~> Exec['apt_update']
    -> Package['php5-mysql']

  if defined(Service['apache2']) {
    Package['php5-mysql'] ~> Service['apache2']
  }

}
