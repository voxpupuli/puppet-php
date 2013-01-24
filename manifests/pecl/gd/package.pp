# == Class: php::pecl::gd::package
#
# Install the PHP gd extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*php_version*]
#   The version of gd to install
#
# === Examples
#
#  include php::pecl::gd::package
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::gd::package {

  php::pecl::package { 'gd': }

}
