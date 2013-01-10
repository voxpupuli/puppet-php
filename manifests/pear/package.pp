class php::pear::package {

	package {
		"php-pear":
			ensure => $php_version;
	}

	Apt::Source["dotdeb"]
		~> Exec["apt_update"]
		-> Package["php-pear"]

}
