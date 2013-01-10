class php::pecl::gearman::package {

	package {
		"php5-gearman":
			ensure  => $php_version;
	}

	Apt::Source["dotdeb"]
		~> Exec["apt_update"]
		-> Package["php5-gearman"]

	if defined(Service['apache2']) {
		Package["php5-gearman"] ~> Service["apache2"]
	}

}
