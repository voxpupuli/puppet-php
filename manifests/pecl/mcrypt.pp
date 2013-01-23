# == Class: php::pecl::mcrypt
#
# Install the mcrypt PHP extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*php_version*]
#   The version of mcrypt to install
#
# === Examples
#
#  include php::pecl::mcrypt
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::mcrypt {

	include php::pecl::mcrypt::package

}
