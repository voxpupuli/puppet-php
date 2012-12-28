class php::pecl::imagick::package {

	package {
		"php5-imagick":
			ensure  => $php_version;
	}

	Apt::Source["dotdeb"] -> Exec["apt_update"] -> Package["php5-imagick"]

	if defined(Service['apache2']) {
		Package["php5-imagick"] ~> Service["apache2"]
	}

}
