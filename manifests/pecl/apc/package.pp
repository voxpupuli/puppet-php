# == Class: php::pecl::apc::package
#
# Install the PHP APC extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*php_version*]
#   The version of APC to install
#
# === Examples
#
#  include php::pecl::apc::package
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::apc::package {

  include php::params

  package { 'php5-apc':
    ensure => $php::params::php_version;
  }

  Apt::Source['dotdeb'] ~> Exec['apt_update'] -> Package['php5-apc']

  if defined(Class[$php::params::web_service]) {
    Package['php5-apc'] ~> Class[$php::params::web_service]
  }

}
