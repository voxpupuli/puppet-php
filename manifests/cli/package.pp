class php::cli::package {

	package {
		'php5-cli':
        	ensure => $php_version;
		'php5':
			ensure  => $php_version;
    }

	Apt::Source["dotdeb"] ~> Exec["apt_update"] -> Package["php5-cli"]
	Apt::Source["dotdeb"] ~> Exec["apt_update"] -> Package["php5"]

}
