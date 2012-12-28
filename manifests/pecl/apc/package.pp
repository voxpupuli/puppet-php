class php::pecl::apc::package {

	package {
		"php5-apc":
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
