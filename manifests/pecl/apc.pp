# == Class: php::pecl::apc
#
# Install and configure the APC PHP extension
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
#  include php::pecl::apc
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::apc {

	include php::pecl::apc::package
	include php::pecl::apc::config

}
