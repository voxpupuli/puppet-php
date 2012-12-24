class php::pecl::http::package {

	package {
		"pecl_http":
			ensure => installed,
			provider => pecl,
			pipe => "echo 'y
			y
			n'",
			require => [
				Package["libcurl3-dev"],
				Package["libmagick++-dev"]
			]
	}

	package {
		"libcurl3-dev":
			ensure => installed;
		"libmagick++-dev":
			ensure => installed;
	}

}
