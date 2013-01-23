# == Class: php::composer::package
#
# PHP Composer package
#
# Will install the PHP package manager "Composer"
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
#  include php::cli::package
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::composer::package {

  exec { 'download composer':
    command => 'wget http://getcomposer.org/composer.phar -O /usr/local/bin/composer',
    creates => '/usr/local/bin/composer'
  }

  file { '/usr/local/bin/composer':
    mode    => '0755',
    owner   => root,
    group   => root,
    require => Exec['download composer']
  }

}
