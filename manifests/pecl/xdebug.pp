# == Class: php::pecl::xdebug
#
# Install and configure the xdebug PHP extension
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
#  include php::pecl::xdebug
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::xdebug {

  include php::pecl::xdebug::package
  include php::pecl::xdebug::config

}
