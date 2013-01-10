class php::apache::package {

	package {
		'libapache2-mod-php5':
        	ensure  => $php_version,
        	alias   => 'mod_php5'
    }

	Apt::Source["dotdeb"]
		~> Exec["apt_update"]
		-> Package["apache2"]
		-> Package["libapache2-mod-php5"]

}
