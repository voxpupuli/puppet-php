# == Class: php::apache
#
# Install and configure mod_php for apache
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
#  include php::apache
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::apache {

	include php::apache::package

	php::apache::config {
		'PHP/short_open_tag': 		value => 'Off';
		'PHP/asp_tags':				value => 'Off';
		'PHP/expose_php':			value => 'Off';
		'PHP/memory_limit':			value => '256M';
		'PHP/display_errors':		value => 'Off';
		'PHP/log_errors':			value => 'On';
		'PHP/post_max_size':		value => '500M';
		'PHP/upload_max_filesize':	value => '500M';
		'PHP/max_execution_time':	value => 600;
		'PHP/allow_url_include':	value => 'Off';
		'PHP/error_log':			value => 'syslog';
		'PHP/output_buffering':		value => 4096;
		'PHP/output_handler':		value => 'Off';
		'Date/date.timezone':		value => 'UTC';
	}

}
