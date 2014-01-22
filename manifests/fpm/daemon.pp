# Class: php::fpm::daemon
#
# Install the PHP FPM daemon. See php::fpm::conf for configuring its pools.
#
# Sample Usage:
#  include php::fpm::daemon
#
class php::fpm::daemon (
  $ensure       = 'present',
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

  if ($ensure == 'present') {

    service { 'php5-fpm':
      ensure    => running,
      enable    => true,
      restart   => 'service php5-fpm reload',
      hasstatus => true,
      require   => Package['php5-fpm'],
    }

    file { '/etc/php5/fpm/php-fpm.conf':
      notify  => Service['php5-fpm'],
      content => template('php/fpm/php-fpm.conf.erb'),
      owner   => root,
      group   => root,
      mode    => '0644',
    }

  }

}
