class php::pecl::http::package {

	package {
		"pecl_http":
			ensure => installed,
			provider => pecl,
			pipe => "echo 'y
			y
			n'";
	}

	package {
		["libcurl4-openssl-dev", "libmagick++-dev"]:
			ensure => installed;
	}

	Apt::Source["dotdeb"]
		~> Exec["apt_update"]
		-> Package['libcurl4-openssl-dev']
		-> Package['libmagick++-dev']
		-> Package['php5-dev']
		-> Package['pecl_http']

	if defined(Service['apache2']) {
		Package["pecl_http"] ~> Service["apache2"]
	}

}
