# == Class: php::xdebug::ssh2::package
#
# Install the PHP xdebug extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*php_version*]
#   The version of xdebug to install
#
# === Examples
#
#  include php::pecl::xdebug::package
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::xdebug::package {

  package { 'xdebug':
    ensure   => installed,
    provider => pecl;
  }

  Apt::Source['dotdeb']
    ~> Exec['apt_update']
    -> Package['php5-dev']
    -> Package['xdebug']

  if defined(Service['apache2']) {
    Package['xdebug'] ~> Service['apache2']
  }

}
