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
  $log_dir_mode = '0770',
  $pool_base_dir = $php::fpm::params::pool_base_dir,
) {

  # Hack-ish to default to user for group too
  $log_group_final = $log_group ? {
    false   => $log_owner,
    default => $log_group,
  }

  if ($ensure == 'present') {

    service { 'php-fpm':
      ensure    => running,
      enable    => true,
      restart   => 'service php-fpm reload',
      hasstatus => true,
      require   => Package[$php::fpm::params::package],
    }

    case $operatingsystem {
      CentOS: { $conffile = $php::fpm::params::inifile }
      default: { $conffile = '/etc/php5/fpm/php-fpm.conf' }
    }

    file { $conffile:
      notify  => Service['php-fpm'],
      content => template('php/fpm/php-fpm.conf.erb'),
      owner   => root,
      group   => root,
      mode    => '0644',
    }

  }

}
