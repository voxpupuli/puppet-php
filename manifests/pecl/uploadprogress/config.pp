class php::pecl::uploadprogress::config {

	file {
		'/etc/php5/conf.d/uploadprogress.ini':
			owner => root,
			group => root,
			mode => 755,
			ensure => file,
			content => 'extension=uploadprogress.so',
			require => Package["uploadprogress"],
			notify => [
				defined(Service['apache2']) ? {
					true    => Service['apache2'],
					default => []
				}
		];
	}

}
