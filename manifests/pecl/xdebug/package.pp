class php::pecl::xdebug::package {

	package {
		"xdebug":
			ensure 	 => installed,
			provider => pecl;
	}

	Apt::Source["dotdeb"]
		~> Exec["apt_update"]
		-> Package["php5-dev"]
		-> Package["xdebug"]

	if defined(Service['apache2']) {
		Package["xdebug"] ~> Service["apache2"]
	}


}
