# == Class: php::pecl::imagick
#
# Install the imagick PHP extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*php_version*]
#   The version of imagick to install
#
# === Examples
#
#  include php::pecl::imagick
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::imagick {

	include php::pecl::imagick::package

}
