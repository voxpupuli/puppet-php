class php::pecl::ssh2::package {

	package {
		"php5-ssh2":
			ensure  => $php_version;
	}

	Apt::Source["dotdeb"] -> Exec["apt_update"] -> Package["php5-ssh2"]

	if defined(Service['apache2']) {
		Package["php5-ssh2"] ~> Service["apache2"]
	}

}
