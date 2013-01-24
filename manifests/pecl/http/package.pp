# == Class: php::pecl::http::package
#
# Install the PHP http extension
#
# Will also install contrib packages required to
# compile the extension on the machine
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*php_version*]
#   The version of http to install
#
# === Examples
#
#  include php::pecl::http::package
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::http::package {

  php::pecl::package { 'http': }

  package {
    'libcurl4-openssl-dev':
      ensure => installed;
    'libmagick++-dev':
      ensure => installed;
  }
}
