# == Class: php::pecl::xdebug::config
#
# Configure the PHP xdebug extension
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
#  include php::pecl::xdebug::config
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::xdebug::config {

  file { '/etc/php5/conf.d/xdebug.ini':
    ensure  => file,
    mode    => '0755',
    owner   => root,
    group   => root,
    content => 'zend_extension="/usr/lib/php5/20100525/xdebug.so"
    xdebug.max_nesting_level=1000';
  }

  Package['xdebug'] -> File['/etc/php5/conf.d/xdebug.ini']

  if defined(Service['apache2']) {
    File['/etc/php5/conf.d/xdebug.ini'] ~> Service['apache2']
  }

}
