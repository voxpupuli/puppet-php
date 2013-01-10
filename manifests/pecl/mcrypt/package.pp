class php::pecl::mcrypt::package {

	package {
		"php5-mcrypt":
			ensure  => $php_version;
	}

	Apt::Source["dotdeb"]
		~> Exec["apt_update"]
		-> Package["php5-mcrypt"]

	if defined(Service['apache2']) {
		Package["php5-mcrypt"] ~> Service["apache2"]
	}

}
