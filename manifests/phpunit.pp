class php::phpunit {

	package {
		"pear.phpunit.de/PHPUnit":
			ensure 		=> "3.7.12",
			provider	=> pear;
	}

	exec {
		"pear auto_discover":
			command 	=> "pear config-set auto_discover 1 system",
			refreshonly	=> true,
	}

	Package["php-pear"]
		~> Exec["pear auto_discover"]
		-> Package["pear.phpunit.de/PHPUnit"]

}
