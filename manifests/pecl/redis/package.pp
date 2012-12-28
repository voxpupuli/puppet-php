class php::pecl::redis::package {

	file {
		"/opt/php":
			ensure => "directory",
			recurse => true;

		"/opt/php/phpredis":
			ensure => "directory",
			recurse => true;
	}

	exec {
		"redis_fetch_source":
			command => "wget https://github.com/nicolasff/phpredis/archive/2.2.2.tar.gz",
			creates	=> "/opt/php/phpredis/2.2.2.tar.gz",
			cwd		=> "/opt/php/phpredis";

		"redis_extract_source":
			command => "tar zxf 2.2.2.tar.gz",
			creates	=> "/opt/php/phpredis/phpredis-2.2.2",
			cwd		=> "/opt/php/phpredis";

		"redis_build_source":
			command => "phpize && ./configure --enable-redis-igbinary && make install",
			creates => "/usr/lib/php5/20100525/redis.so",
			cwd		=> "/opt/php/phpredis/phpredis-2.2.2";
	}

	File["/opt/php"]
		-> File["/opt/php/phpredis"]
		-> Exec["redis_fetch_source"]
		-> Exec["redis_extract_source"]
		-> Exec["redis_build_source"]

	Apt::Source["dotdeb"] -> Exec["apt_update"] -> Exec["redis_build_source"]

}
