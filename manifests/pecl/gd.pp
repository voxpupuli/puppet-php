# == Class: php::pecl::gd
#
# Install the gd PHP extension
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
#  include php::pecl::gd
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::gd {

  include php::pecl::gd::package

}
