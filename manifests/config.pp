# == Class: php::config
#
# Configure php.ini settings for a PHP SAPI
#
# === Parameters
#
# [*key*]
#   The php.ini settings key
#
# [*value*]
#   The php.ini setting value
#
# [*sapi*]
#   The PHP sapi (cli or apache2)
#
# === Variables
#
# No variables
#
# === Examples
#
#  php::config { "sample": key => 'PHP/short_open_tag', value => 'Off', 'sapi' => 'cli'; }
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
define php::config($key, $value, $sapi) {

	augeas { "php/$sapi/$key":
		context => "/files/etc/php5/$sapi/php.ini",
		changes => [
			"set '$key' '$value'"
		];
	}

}
