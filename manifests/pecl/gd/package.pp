class php::pecl::gd::package {

	package {
		"php5-gd":
			ensure  => $php_version;
	}

	Apt::Source["dotdeb"] -> Exec["apt_update"] -> Package["php5-gd"]

	if defined(Service['apache2']) {
		Package["php5-gd"] ~> Service["apache2"]
	}

}
