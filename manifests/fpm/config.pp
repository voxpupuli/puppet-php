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
#   Nested hash of key => value to apply to php.ini
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
# Franz Pletz <franz.pletz@mayflower.de>
#
# === Copyright
#
# See LICENSE file

class php::fpm::config(
  $config_file                 = $php::params::fpm_config_file,
  $user                        = $php::params::fpm_user,
  $group                       = $php::params::fpm_group,
  $php_inifile                 = $php::params::fpm_inifile,
  $php_settings                = {},
  $pool_base_dir               = $php::params::fpm_pool_dir,
  $log_level                   = 'notice',
  $emergency_restart_threshold = '0',
  $emergency_restart_interval  = '0',
  $process_control_timeout     = '0',
  $log_owner                   = $php::params::fpm_user,
  $log_group                   = $php::params::fpm_group,
  $log_dir_mode                = '0770',
) inherits php::params {

  validate_string($user)
  validate_string($group)
  validate_string($php_inifile)
  validate_hash($php_settings)

  $number_re = '^\d+$'

  validate_absolute_path($pool_base_dir)
  validate_string($log_level)
  validate_re($emergency_restart_threshold, $number_re)
  validate_re($emergency_restart_interval, $number_re)
  validate_re($process_control_timeout, $number_re)
  validate_string($log_owner)
  validate_string($log_group)
  validate_re($log_dir_mode, $number_re)


  if $caller_module_name != $module_name {
    warning("${name} is not part of the public API of the ${module_name} module and should not be directly included in the manifest.")
  }

  # Hack-ish to default to user for group too
  $log_group_final = $log_group ? {
    undef   => $log_owner,
    default => $log_group,
  }

  file { $config_file:
    ensure  => present,
    notify  => Class['php::fpm::service'],
    content => template('php/fpm/php-fpm.conf.erb'),
    owner   => root,
    group   => root,
    mode    => '0644',
  }

  file { $pool_base_dir:
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '0755',
  }

  php::config { 'fpm':
    file   => $php_inifile,
    config => $php_settings,
    notify => Class['php::fpm::service'],
  }
}
