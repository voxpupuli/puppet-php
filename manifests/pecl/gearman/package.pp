class php::pecl::gearman::package {

	package {
		"php5-gearman":
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
