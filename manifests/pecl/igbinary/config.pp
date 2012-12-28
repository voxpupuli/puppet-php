class php::pecl::igbinary::config {

	file {
		'/etc/php5/conf.d/igbinary.ini':
			owner => root,
			group => root,
			mode => 755,
			ensure => file,
			content => 'extension=igbinary.so';
	}


	Package["igbinary"] -> File["/etc/php5/conf.d/igbinary.ini"]

	if defined(Service["apache2"]) {
		File["/etc/php5/conf.d/igbinary.ini"] ~> Service["apache2"]
	}

}
