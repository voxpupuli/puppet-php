class php::pecl::igbinary::config {

	file {
		'/etc/php5/conf.d/igbinary.ini':
			owner => root,
			group => root,
			mode => 755,
			ensure => file,
			content => 'extension=igbinary.so',
			require => Package["igbinary"],
			notify => [
				defined(Service['apache2']) ? {
					true    => Service['apache2'],
					default => []
				}
		];
	}

}
