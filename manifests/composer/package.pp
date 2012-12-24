class php::composer::package {

	exec {
		"download composer":
			command => "wget http://getcomposer.org/composer.phar -O /usr/local/bin/composer",
			creates	=> "/usr/local/bin/composer"
	}

	file {
		"/usr/local/bin/composer":
			mode => 0755,
			owner => root,
			group => root,
			require => Exec["download composer"]
	}

}
