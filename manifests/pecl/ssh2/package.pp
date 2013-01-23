# == Class: php::pecl::ssh2::package
#
# Install the PHP ssh2 extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*php_version*]
#   The version of ssh2 to install
#
# === Examples
#
#  include php::pecl::ssh2::package
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::ssh2::package {

	package { "php5-ssh2":
		ensure  => $php_version;
	}

	Apt::Source["dotdeb"]
		~> Exec["apt_update"]
		-> Package["php5-ssh2"]

	if defined(Service['apache2']) {
		Package["php5-ssh2"] ~> Service["apache2"]
	}

}
