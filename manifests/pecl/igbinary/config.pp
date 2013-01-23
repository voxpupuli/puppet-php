# == Class: php::pecl::igbinary::config
#
# Configure the PHP igbinary extension
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
#  include php::pecl::igbinary::config
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::igbinary::config {

  file { '/etc/php5/conf.d/igbinary.ini':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0755',
    content => 'extension=igbinary.so';
  }

  Package['igbinary'] -> File['/etc/php5/conf.d/igbinary.ini']

  if defined(Service['apache2']) {
    File['/etc/php5/conf.d/igbinary.ini'] ~> Service['apache2']
  }

}
