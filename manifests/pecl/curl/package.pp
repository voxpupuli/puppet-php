class php::pecl::curl::package {

	package {
		"php5-curl":
			ensure  => $php_version;
	}

	Apt::Source["dotdeb"] -> Exec["apt_update"] -> Package["php5-curl"]

	if defined(Service['apache2']) {
		Package["php5-curl"] ~> Service["apache2"]
	}

}
