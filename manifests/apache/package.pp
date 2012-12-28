class php::apache::package {

	package {
		'libapache2-mod-php5':
        	ensure  => $php_version,
        	alias   => 'mod_php5',
        	require => [
        		Package['apache2']
        	];
    }

	Apt::Source["dotdeb"] -> Exec["apt_update"] -> Package["libapache2-mod-php5"]

}
