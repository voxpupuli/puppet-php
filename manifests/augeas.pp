# == Class: php::augeas
#
# php augeas class
#
# Ensure that the php augeas lense is loaded
#
# This lense supports php fpm format
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
#  include php::augeas
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
class php::augeas {

  if !defined(File['/usr/share/augeas/lenses/contrib']) {
    file { "/usr/share/augeas/lenses/contrib":
      ensure  => directory,
      recurse => true,
      purge   => true,
      force   => true,
      mode    => '0644',
      owner   => "root",
      group   => "root"
    }
  }

  file { '/usr/share/augeas/lenses/contrib/php.aug':
    ensure  => present,
    source  => 'puppet:///modules/php/php.aug',
    require => File['/usr/share/augeas/lenses/contrib']
  }

}
