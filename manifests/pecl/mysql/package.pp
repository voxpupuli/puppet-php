class php::pecl::mysql::package {

	package {
		"php5-mysql":
			ensure  => $php_version;
	}

	Apt::Source["dotdeb"] -> Exec["apt_update"] -> Package["php5-mysql"]

	if defined(Service['apache2']) {
		Package["php5-mysql"] ~> Service["apache2"]
	}

}
