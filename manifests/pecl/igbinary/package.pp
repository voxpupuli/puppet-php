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

	package { "igbinary":
		ensure => installed,
		provider => pecl;
	}

	Apt::Source["dotdeb"]
		~> Exec["apt_update"]
		-> Package['php5-dev']
		-> Package["igbinary"]

	if defined(Service['apache2']) {
		Package["igbinary"] ~> Service["apache2"]
	}

}
