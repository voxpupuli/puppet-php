# == Class: php::pecl::redis::config
#
# Configure the PHP redis extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# No variables
#
# === Examples
#
#  include php::pecl::redis::config
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::redis::config {

    file { '/etc/php5/conf.d/redis.ini':
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
