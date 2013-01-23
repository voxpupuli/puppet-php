# == Class: php::apache::config
#
# PHP apache SAPI configuration
#
# Wrapper for php::config which will change augeas settings in the right
# SAPI php.ini
#
# The *$name* of the php::apache::config call is used as key inside the
# augeas call. For list of valid values run augtool /files/etc/php5/apache2/php.ini
#
# === Parameters
#
# [*value*]
#   The php.ini setting value
#
# === Variables
#
# No variables
#
# === Examples
#
#  php::apache::config { "PHP/short_open_tag": value => 'Off' }
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
define php::apache::config($value) {

	$notify = [
		Service['apache2']
	]

	$require = [
		Package['libapache2-mod-php5']
	]

	php::config { "apache/$name":
		sapi 	=> 'apache2',
		notify 	=> $notify,
		require => $require,
		key		=> $name,
		value 	=> $value;
	}

}
