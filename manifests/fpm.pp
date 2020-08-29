# Install and configure mod_php for fpm
#
# === Parameters
#
# [*user*]
#   The user that php-fpm should run as
#
# [*group*]
#   The group that php-fpm should run as
#
# [*service_enable*]
#   Enable/disable FPM service
#
# [*service_ensure*]
#   Ensure FPM service is either 'running' or 'stopped'
#
# [*service_name*]
#   This is the name of the php-fpm service. It defaults to reasonable OS
#   defaults but can be different in case of using php7.0/other OS/custom fpm service
#
# [*service_provider*]
#   This is the name of the service provider, in case there is a non
#   OS default service provider used to start FPM.
#   Defaults to 'undef', pick system defaults.
#
# [*pools*]
#   Hash of php::fpm::pool resources that will be created. Defaults
#   to a single php::fpm::pool named www with default parameters.
#
# [*log_owner*]
#   The php-fpm log owner
#
# [*log_group*]
#   The group owning php-fpm logs
#
# [*package*]
#   Specify which package to install
#
# [*ensure*]
#   Specify which version of the package to install
#
# [*inifile*]
#   Path to php.ini for fpm
#
# [*settings*]
#   fpm settings hash
#
# [*global_pool_settings*]
#   Hash of defaults params php::fpm::pool resources that will be created.
#   Defaults is empty hash.
#
# [*pool_purge*]
#   Whether to purge pool config files not created
#   by this module
#
# [*reload_fpm_on_config_changes*]
#   by default, we reload the service on changes.
#   But certain options, like socket owner, will only be applied during a restart.
#   If set to false, a restart will be executed instead of a reload.
#   This default will be changed in a future release.
#
class php::fpm (
  String $ensure                        = $php::ensure,
  $user                                 = $php::fpm_user,
  $group                                = $php::fpm_group,
  $service_ensure                       = $php::fpm_service_ensure,
  $service_enable                       = $php::fpm_service_enable,
  $service_name                         = $php::fpm_service_name,
  $service_provider                     = $php::fpm_service_provider,
  String $package                       = $php::real_fpm_package,
  Stdlib::Absolutepath $inifile         = $php::fpm_inifile,
  Hash $settings                        = $php::real_settings,
  $global_pool_settings                 = $php::real_fpm_global_pool_settings,
  Hash $pools                           = $php::real_fpm_pools,
  $log_owner                            = $php::log_owner,
  $log_group                            = $php::log_group,
  Boolean $pool_purge                   = $php::pool_purge,
  Boolean $reload_fpm_on_config_changes = $php::reload_fpm_on_config_changes,
) {
  if ! defined(Class['php']) {
    warning('php::fpm is private')
  }

  $real_settings = $settings

  # On FreeBSD fpm is not a separate package, but included in the 'php' package.
  # Implies that the option SET+=FPM was set when building the port.
  $real_package = $facts['os']['family'] ? {
    'FreeBSD' => [],
    default   => $package,
  }

  package { $real_package:
    ensure  => $ensure,
    require => Class['php::packages'],
  }

  class { 'php::fpm::config':
    user       => $user,
    group      => $group,
    inifile    => $inifile,
    settings   => $real_settings,
    log_owner  => $log_owner,
    log_group  => $log_group,
    pool_purge => $pool_purge,
    require    => Package[$real_package],
  }

  contain 'php::fpm::config'
  contain 'php::fpm::service'

  Class['php::fpm::config'] ~> Class['php::fpm::service']

  $real_global_pool_settings = $global_pool_settings
  $real_pools = $pools
  create_resources(::php::fpm::pool, $real_pools, $real_global_pool_settings)
}
