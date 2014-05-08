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
# See LICENSE file
# FIXME
define php::fpm::config(
  $file                        = $php::params::fpm_inifile,
  $config                      = [],
  $log_level                   = 'notice',
  $emergency_restart_threshold = '0',
  $emergency_restart_interval  = '0',
  $process_control_timeout     = '0',
  $log_owner                   = 'root',
  $log_group                   = undef,
  $log_dir_mode                = '0770'
) {

  if $caller_module_name != $module_name {
    warning("${name} is not part of the public API of the ${module_name} module and should not be directly included in the manifest.")
  }

  # Hack-ish to default to user for group too
  $log_group_final = $log_group ? {
    undef   => $log_owner,
    default => $log_group,
  }

  file { '/etc/php5/fpm/php-fpm.conf':
    notify  => Service[$php::params::fpm_service_name],
    content => template('php/fpm/php-fpm.conf.erb'),
    owner   => root,
    group   => root,
    mode    => '0644',
  }

  file { '/etc/php5/fpm/pool.d':
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => '0755',
  }

  php::config { "fpm-${name}":
    file      => $file,
    config    => $config,
    notify    => Service[$php::params::fpm_service_name]
  }
}
