# == Class: php::fpm::config
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
include php::fpm::params

define php::fpm::config(
  $file         = $::php::fpm::params::inifile,
  $config       = [],
  $log_level    = 'notice',
  $emergency_restart_threshold = '0',
  $emergency_restart_interval  = '0',
  $process_control_timeout     = '0',
  $log_owner    = 'root',
  $log_group    = false,
  $log_dir_mode = '0770'
) {

  # Hack-ish to default to user for group too
  $log_group_final = $log_group ? {
    false   => $log_owner,
    default => $log_group,
  }

  file { '/etc/php5/fpm/php-fpm.conf':
    notify  => Service[$::php::fpm::params::service_name],
    content => template('php/fpm/php-fpm.conf.erb'),
    owner   => root,
    group   => root,
    mode    => '0644',
  } ->
  file { '/etc/php5/fpm/pool.d':
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => '0755',
  }

  php::config { "fpm-${name}":
    file      => $file,
    config    => $config,
    notify    => Service[$::php::fpm::params::service_name]
  }
}
