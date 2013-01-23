# == Class: php::dev::package
#
# PHP dev package
#
# Install the development headers for PHP
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*php_version*]
#   The PHP version of PHP cli to install
#
# === Examples
#
#  include php::dev::package
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::dev::package {

	package { "php5-dev":
		ensure => $php_version;
	}

	Apt::Source["dotdeb"]
		~> Exec["apt_update"]
		-> Package["php5-dev"]

}
