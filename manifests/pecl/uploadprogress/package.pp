# == Class: php::peck::uploadprogress::package
#
# Install the PHP uploadprogress extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*php_version*]
#   The version of uploadprogress to install
#
# === Examples
#
#  include php::pecl::uploadprogress::package
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::uploadprogress::package {

  php::pecl::package { 'uploadprogress': }

}
