class php::dev::package {

	package {
		"php5-dev":
			ensure => $php_version;
	}

	Apt::Source["dotdeb"] -> Exec["apt_update"] -> Package["php5-dev"]

}
