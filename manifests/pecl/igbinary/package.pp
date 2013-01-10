class php::pecl::igbinary::package {

	package {
		"igbinary":
			ensure => installed,
			provider => pecl;
	}

	Apt::Source["dotdeb"]
		~> Exec["apt_update"]
		-> Package['php5-dev']
		-> Package["igbinary"]

	if defined(Service['apache2']) {
		Package["igbinary"] ~> Service["apache2"]
	}

}
