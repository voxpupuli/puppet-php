# == Class: php::pecl::curl::package
#
# Install the PHP curl extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*php_version*]
#   The version of curl to install
#
# === Examples
#
#  include php::pecl::curl::package
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::curl::package {

  php::pecl::package { 'curl': }

}
