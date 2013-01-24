# == Class: php::pecl::gearman::package
#
# Install the PHP gearman extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*php_version*]
#   The version of gearman to install
#
# === Examples
#
#  include php::pecl::gearman::package
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::gearman::package {

  php::pecl::package { 'gearman': }

}
