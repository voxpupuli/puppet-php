class php::pecl::redis::package {

	file {
		"/opt/php/":
			ensure => "directory",
			recurse => true;

		"/opt/php/phpredis":
			ensure => "directory",
			recurse => true,
			require	=> File["/opt/php/"];
	}

	exec {
		"redis_fetch_source":
			command => "wget https://github.com/nicolasff/phpredis/archive/2.2.2.tar.gz",
			require	=> File["/opt/php/phpredis"],
			creates	=> "/opt/php/phpredis/2.2.2.tar.gz",
			cwd		=> "/opt/php/phpredis";

		"redis_extract_source":
			command => "tar zxf 2.2.2.tar.gz",
			require	=> Exec['redis_fetch_source'],
			creates	=> "/opt/php/phpredis/phpredis-2.2.2",
			cwd		=> "/opt/php/phpredis";

		"redis_build_source":
			command => "phpize && ./configure --enable-redis-igbinary && make install",
			require => Exec["redis_extract_source"],
			creates => "/usr/lib/php5/20100525/redis.so",
			cwd		=> "/opt/php/phpredis/phpredis-2.2.2",
			require	=> Package['php5-dev'];
		}

}
