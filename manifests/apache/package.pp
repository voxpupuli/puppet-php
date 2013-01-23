# == Class: php::apache::package
#
# PHP mod_php package
#
# Will install mod_php for apache
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*php_version*]
#   The PHP version of mod_php to install
#
# === Examples
#
#  include php::apache::package
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::apache::package {

  package { 'libapache2-mod-php5':
    ensure => $::php_version,
    alias  => 'mod_php5';
  }

  Apt::Source['dotdeb']
    ~> Exec['apt_update']
    -> Package['apache2']
    -> Package['libapache2-mod-php5']

}
