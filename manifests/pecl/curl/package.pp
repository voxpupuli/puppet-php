# == Class: php::pecl::curl::package
#
# Install the PHP curl extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*php_version*]
#   The version of curl to install
#
# === Examples
#
#  include php::pecl::curl::package
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::curl::package {

  package { 'php5-curl':
    ensure => $::php_version;
  }

  Apt::Source['dotdeb']
    ~> Exec['apt_update']
    -> Package['php5-curl']

  if defined(Service['apache2']) {
    Package['php5-curl'] ~> Service['apache2']
  }

}
