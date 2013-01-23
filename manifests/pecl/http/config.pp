# == Class: php::pecl::http::config
#
# Configure the PHP http extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# No variables
#
# === Examples
#
#  include php::pecl::http::config
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::http::config {

	file { '/etc/php5/conf.d/http.ini':
		owner 	=> root,
		group 	=> root,
		mode 	=> 755,
		ensure 	=> file,
		content => 'extension=http.so';
	}

	Package["pecl_http"] -> File["/etc/php5/conf.d/http.ini"]

	if defined(Service["apache2"]) {
		File["/etc/php5/conf.d/http.ini"] ~> Service["apache2"]
	}

}
