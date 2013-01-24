# == Class: php::pecl::imagick::package
#
# Install the PHP imagick extension
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
#  include php::pecl::imagick::package
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::imagick::package {

  php::pecl::package { 'imagick': }

}
