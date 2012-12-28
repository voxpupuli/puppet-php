class php::pecl::uploadprogress::package {

	package {
		"uploadprogress":
			ensure 	 => installed,
			provider => pecl;
	}

	Apt::Source["dotdeb"]
		-> Exec["apt_update"]
		-> Package["php5-dev"]
		-> Package["uploadprogress"]

	if defined(Service['apache2']) {
		Package["uploadprogress"] ~> Service["apache2"]
	}

}
