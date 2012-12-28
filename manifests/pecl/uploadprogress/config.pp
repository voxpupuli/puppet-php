class php::pecl::uploadprogress::config {

	file {
		'/etc/php5/conf.d/uploadprogress.ini':
			owner => root,
			group => root,
			mode => 755,
			ensure => file,
			content => 'extension=uploadprogress.so';
	}

	Package["uploadprogress"] -> File["/etc/php5/conf.d/uploadprogress.ini"]

	if defined(Service['apache2']) {
		File["/etc/php5/conf.d/uploadprogress.ini"] ~> Service["apache2"]
	}

}
