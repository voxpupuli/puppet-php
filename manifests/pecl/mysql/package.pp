class php::pecl::mysql::package {

	package {
		"php5-mysql":
			ensure  => $php_version,
			notify => [
				defined(Service['apache2']) ? {
					true => Service['apache2'],
					default => [ ]
				}
			],
			require => [
				Apt::Source['dotdeb']
			];
	}

}
