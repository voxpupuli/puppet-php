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

  php::pecl::package { 'xdebug': }

}
