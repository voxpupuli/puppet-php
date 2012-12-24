class php::pecl::ssh2::package {

	package {
		"php5-ssh2":
			ensure  => $php_version,
			notify => [
				defined(Service['apache2']) ? {
					true => Service['apache2'],
					default => [ ]
				}
			];
	}

}
