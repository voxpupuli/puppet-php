class php::pecl::imagick::package {

	package {
		"php5-imagick":
			ensure  => $php_version,
			notify => [
				defined(Service['apache2']) ? {
					true => Service['apache2'],
					default => [ ]
				}
			];
	}

	Apt::Source["dotdeb"] -> Exec["apt_update"] -> Package["php5-imagick"]

}
