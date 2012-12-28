class php::pear::package {

	package {
		"php-pear":
			ensure => $php_version,
			require => [
				Apt::Source['dotdeb']
			];
	}

}
