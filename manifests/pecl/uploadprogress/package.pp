# == Class: php::uploadprogress::ssh2::package
#
# Install the PHP uploadprogress extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*php_version*]
#   The version of uploadprogress to install
#
# === Examples
#
#  include php::pecl::uploadprogress::package
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::uploadprogress::package {

  package { 'uploadprogress':
    ensure   => installed,
    provider => pecl;
  }

  Apt::Source['dotdeb']
    ~> Exec['apt_update']
    -> Package['php5-dev']
    -> Package['uploadprogress']

  if defined(Service['apache2']) {
    Package['uploadprogress'] ~> Service['apache2']
  }

}
