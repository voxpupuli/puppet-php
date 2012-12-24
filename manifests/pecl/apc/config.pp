class php::pecl::apc::config {

	augeas {
		"php-apc":
			context => "/files/etc/php5/conf.d/20-apc.ini",
			changes => [
				"set .anon/apc.enabled 1",
				"set .anon/apc.cache_by_default 1",
				"set .anon/apc.stat 0",
				"set .anon/apc.include_once_override 1",
				"set .anon/apc.localcache 1",
				"set .anon/apc.localcache.size 10000",
				"set .anon/apc.shm_size 1G",
				"set .anon/apc.localcache 1",
				"set .anon/apc.localcache.size 5000",
				"set .anon/apc.apc.write_lock 1",
				"set .anon/apc.num_files_hint 10000",
				"set .anon/apc.user_entries_hint 40960",
				"set .anon/apc.file_update_protection 0",
				"set .anon/apc.enable_cli 0"
			],
			require => [
				Package['php5-apc']
			],
			notify => [
				defined(Service['apache2']) ? {
					true => Service['apache2'],
					default => []
				}
			]
		}

}
