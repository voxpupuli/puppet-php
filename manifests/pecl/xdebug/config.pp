class php::pecl::xdebug::config {

	file {
		'/etc/php5/conf.d/xdebug.ini':
			owner => root,
			group => root,
			mode => 755,
			ensure => file,
			content => 'zend_extension="/usr/lib/php5/20100525/xdebug.so"
			xdebug.max_nesting_level=1000';
	}

	Package["xdebug"] -> File["/etc/php5/conf.d/xdebug.ini"]

	if defined(Service['apache2']) {
		File["/etc/php5/conf.d/xdebug.ini"] ~> Service["apache2"]
	}

}
