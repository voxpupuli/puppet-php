# == Class: php::pecl::http
#
# Install and configure the http PHP extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*php_version*]
#   The version of http to install
#
# === Examples
#
#  include php::pecl::http
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::http {

	include php::pecl::http::package
	include php::pecl::http::config

}
