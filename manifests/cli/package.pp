class php::cli::package {

	package {
		'php5-cli':
        	ensure => $php_version,
			require => [
				Apt::Source['dotdeb']
			];
		'php5':
			ensure  => $php_version,
			require => [
				Apt::Source['dotdeb']
			];
    }

}
