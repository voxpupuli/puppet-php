# == Class: php::apache::config
#
# Configure php.ini settings for a PHP SAPI
#
# === Parameters
#
# [*file*]
#   The path to ini file
#
# [*config*]
#   Array of augeas commands, one command per entry
#
# === Variables
#
# No variables
#
# === Examples
#
# TODO
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
define php::apache::config(
  $file = $php::apache::params::inifile,
  $config
) {

  php::config { "apache-${name}":
    file      => $file,
    config    => $config,
    notify    => Service[$php::apache::params::service_name]
  }

}
