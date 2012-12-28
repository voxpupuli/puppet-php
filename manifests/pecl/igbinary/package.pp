class php::pecl::igbinary::package {

	package {
		"igbinary":
			ensure => installed,
			provider => pecl,
			require => Package['php5-dev']

	}

}
