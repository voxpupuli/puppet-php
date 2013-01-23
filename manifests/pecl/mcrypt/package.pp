# == Class: php::pecl::mcrypt::package
#
# Install the PHP mcrypt extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*php_version*]
#   The version of mcrypt to install
#
# === Examples
#
#  include php::pecl::mcrypt::package
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::mcrypt::package {

  package { 'php5-mcrypt':
    ensure => $::php_version;
  }

  Apt::Source['dotdeb']
    ~> Exec['apt_update']
    -> Package['php5-mcrypt']

  if defined(Service['apache2']) {
    Package['php5-mcrypt'] ~> Service['apache2']
  }

}
