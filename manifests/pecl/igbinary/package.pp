class php::pecl::igbinary::package {

	package {
		"igbinary":
			ensure => installed,
			provider => pecl,
			require => [
				Package['php5-dev'],
				Class['php']
			];
	}

	Apt::Source["dotdeb"] -> Exec["apt_update"] -> Package["igbinary"]

}
