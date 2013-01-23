# == Class: php::pecl::uploadprogress::config
#
# Configure the PHP uploadprogress extension
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
#  include php::pecl::uploadprogress::config
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::uploadprogress::config {

  file { '/etc/php5/conf.d/uploadprogress.ini':
    ensure  => file,
    mode    => '0755',
    owner   => root,
    group   => root,
    content => 'extension=uploadprogress.so';
  }

  Package['uploadprogress'] -> File['/etc/php5/conf.d/uploadprogress.ini']

  if defined(Service['apache2']) {
    File['/etc/php5/conf.d/uploadprogress.ini'] ~> Service['apache2']
  }

}
