# == Class: php::composer::auto_update
#
# Install composer package manager
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
#  include php::composer::auto_update
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
class php::composer::auto_update($max_age = 30) {

  exec { 'update composer':
    command => 'wget http://getcomposer.org/composer.phar -O /usr/local/bin/composer',
    onlyif  => "find '/usr/local/bin/composer' -mtime +${max_age}",
    path    => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
    require => File['/usr/local/bin/composer'];
  }

}
