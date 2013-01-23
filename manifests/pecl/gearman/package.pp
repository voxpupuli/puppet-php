# == Class: php::pecl::gearman::package
#
# Install the PHP gearman extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*php_version*]
#   The version of gearman to install
#
# === Examples
#
#  include php::pecl::gearman::package
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::gearman::package {

  package { 'php5-gearman':
    ensure => $::php_version;
  }

  Apt::Source['dotdeb']
    ~> Exec['apt_update']
    -> Package['php5-gearman']

  if defined(Service['apache2']) {
    Package['php5-gearman'] ~> Service['apache2']
  }

}
