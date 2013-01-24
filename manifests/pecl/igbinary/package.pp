# == Class: php::pecl::igbinary::package
#
# Install the PHP igbinary extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*php_version*]
#   The version of igbinary to install
#
# === Examples
#
#  include php::pecl::igbinary::package
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::igbinary::package {

  php::pecl::package { 'igbinary': }

}
