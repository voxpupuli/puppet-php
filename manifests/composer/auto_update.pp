# == Class: php::composer::auto_update
#
# Install composer package manager
#
# === Parameters
#
# [*max_age*]
# Defines number of days after which Composer should be updated
#
# [*source*]
# Holds URL to the Composer source file
#
# [*destination*]
# Holds path to the Composer executable
#
# === Variables
#
# No variables
#
# === Examples
#
#  include php::composer::auto_update
#  class { "php::composer::auto_update":
#    "max_age" => 90
#  }
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
class php::composer::auto_update (
  $max_age = $php::composer::params::max_age,
  $source = $php::composer::params::source,
  $destination = $php::composer::params::destination
) inherits php::composer::params {

  exec { 'update composer':
    command => "wget ${source} -O ${destination}",
    onlyif  => "test `find '${destination}' -mtime +${max_age}`",
    path    => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
    require => File[$destination],
  }

}
