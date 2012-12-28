class php::pecl::apc::package {

	package {
		"php5-apc":
			ensure  => $php_version;
	}

	Apt::Source["dotdeb"] -> Exec["apt_update"] -> Package["php5-apc"]

	if defined(Service['apache2']) {
		Package["php5-apc"]	~> Service["apache2"]
	}

}
