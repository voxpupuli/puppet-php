class php::apache::package {

	package {
		'libapache2-mod-php5':
        	ensure  => $php_version,
        	alias   => 'mod_php5',
        	require => [
        		Package['apache2'],
				Apt::Source['dotdeb']
        	];
		'php5':
        	ensure  => $php_version,
			require => [
				Apt::Source['dotdeb']
			];
    }

}
