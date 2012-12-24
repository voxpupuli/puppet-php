class php::pecl::redis::config {
    file {
        '/etc/php5/conf.d/redis.ini':
            content => 'extension=redis.so',
            owner   => 'root',
            group   => 'root',
            mode    => 644,
            notify => [
               defined(Service['apache2']) ? {
                    true    => Service['apache2'],
                    default => []
               }
       ],
        ensure  => 'file';
    }

}
