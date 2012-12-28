class php::pecl::uploadprogress::package {

	package {
		"uploadprogress":
			ensure => installed,
			provider => pecl,
			require => Package['php5-dev']
	}

}
