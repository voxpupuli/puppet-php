# == Class: php::pecl::imagick::package
#
# Install the PHP imagick extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*php_version*]
#   The version of imagick to install
#
# === Examples
#
#  include php::pecl::imagick::package
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::imagick::package {

  package { 'php5-imagick':
    ensure => $::php_version;
  }

  Apt::Source['dotdeb']
    ~> Exec['apt_update']
    -> Package['php5-imagick']

  if defined(Service['apache2']) {
    Package['php5-imagick'] ~> Service['apache2']
  }

}
