class php::pecl::redis::config {

    file {
        '/etc/php5/conf.d/redis.ini':
            content => 'extension=redis.so',
            owner   => 'root',
            group   => 'root',
            mode    => 644,
            ensure  => 'file';
    }

    Exec["redis_install"] -> File["/etc/php5/conf.d/redis.ini"]

    if defined(Service["apache2"]) {
        File["/etc/php5/conf.d/redis.ini"] ~> Service["apache2"]
    }

}
