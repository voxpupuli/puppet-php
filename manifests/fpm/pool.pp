# == Class: php::fpm::pool
#
# Configure fpm pools
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
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
# Robin Gloster <robin.gloster@mayflower.de>
#
# === Copyright
#
# See LICENSE file
#
define php::fpm::pool (
  $ensure = 'present',
  $listen = '127.0.0.1:9000',
  # Puppet does not allow dots in variable names
  $listen_backlog = '-1',
  $listen_allowed_clients = '127.0.0.1',
  $listen_owner = undef,
  $listen_group = undef,
  $listen_mode = undef,
  $user = $php::fpm::config::user,
  $group = $php::fpm::config::group,
  $pm = 'dynamic',
  $pm_max_children = '50',
  $pm_start_servers = '5',
  $pm_min_spare_servers = '5',
  $pm_max_spare_servers = '35',
  $pm_max_requests = '0',
  $pm_status_path = undef,
  $ping_path = undef,
  $ping_response = 'pong',
  $request_terminate_timeout = '0',
  $request_slowlog_timeout = '0',
  $security_limit_extensions = undef,
  $slowlog = "/var/log/php-fpm/${name}-slow.log",
  $rlimit_files = undef,
  $rlimit_core = undef,
  $chroot = undef,
  $chdir = undef,
  $catch_workers_output = 'no',
  $env = [],
  $env_value = {},
  $php_value = {},
  $php_flag = {},
  $php_admin_value = {},
  $php_admin_flag = {},
  $php_directives = [],
  $error_log = true,
) {

  include php::params

  if $caller_module_name != $module_name {
    warning("${name} is not part of the public API of the ${module_name} module and should not be directly included in the manifest.")
  }

  $pool = $title

  # Hack-ish to default to user for group too
  $group_final = $group ? { undef => $user, default => $group }

  if ($ensure == 'absent') {
    file { "${php::params::fpm_pool_dir}/${pool}.conf":
      ensure => absent,
      notify => Class['php::fpm::service'],
    }
  } else {
    file { "${php::params::fpm_pool_dir}/${pool}.conf":
      ensure  => file,
      notify  => Class['php::fpm::service'],
      require => Class['php::fpm::package'],
      content => template('php/fpm/pool.conf.erb'),
      owner   => root,
      group   => root,
      mode    => '0644'
    }
  }

}
