# == Class: php::pecl::mysql
#
# Install the mysql PHP extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*php_version*]
#   The version of mysql to install
#
# === Examples
#
#  include php::pecl::mysql
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::mysql {

  include php::pecl::mysql::package

}
