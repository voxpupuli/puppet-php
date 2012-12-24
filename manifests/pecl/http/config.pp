class php::pecl::http::config {

	file {
		'/etc/php5/conf.d/http.ini':
			owner => root,
			group => root,
			mode => 755,
			ensure => file,
			content => 'extension=http.so',
			require => Package['pecl_http'],
			notify => [
				defined(Service['apache2']) ? {
					true    => Service['apache2'],
					default => []
			}
		];
	}

}
