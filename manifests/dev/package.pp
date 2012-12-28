class php::dev::package {

	package {
		"php5-dev":
			ensure => $php_version,
			require => [
				Apt::Source['dotdeb']
			];
	}

}
