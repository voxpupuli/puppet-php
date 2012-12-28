class php::pecl::http::package {

	package {
		"pecl_http":
			ensure => installed,
			provider => pecl,
			pipe => "echo 'y
			y
			n'",
			require => [
				Package["libcurl4-openssl-dev"],
				Package["libmagick++-dev"],
				Package['php5-dev']
			];
	}

	package {
		"libcurl4-openssl-dev":
			ensure => installed;
		"libmagick++-dev":
			ensure => installed;
	}

}
