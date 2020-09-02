# Manage fpm service
#
# === Parameters
#
# [*service_name*]
#   name of the php-fpm service
#
# [*ensure*]
#   'ensure' value for the service
#
# [*enable*]
#   Defines if the service is enabled
#
# [*provider*]
#   Defines if the service provider to use
#
# [*reload_fpm_on_config_changes*]
#   by default, we reload the service on changes.
#   But certain options, like socket owner, will only be applied during a restart.
#   If set to false, a restart will be executed instead of a reload.
#   This default will be changed in a future release.
#
class php::fpm::service (
  $service_name                         = $php::fpm::service_name,
  $ensure                               = $php::fpm::service_ensure,
  $enable                               = $php::fpm::service_enable,
  $provider                             = $php::fpm::service_provider,
  Boolean $reload_fpm_on_config_changes = $php::fpm::reload_fpm_on_config_changes,
) {
  if ! defined(Class['php::fpm']) {
    warning('php::fpm::service is private')
  }

  if $reload_fpm_on_config_changes {
    $restart = "service ${service_name} reload"
  } else {
    $restart = undef
  }
  service { $service_name:
    ensure     => $ensure,
    enable     => $enable,
    provider   => $provider,
    hasrestart => true,
    restart    => $restart,
    hasstatus  => true,
  }

  ::Php::Extension <| |> ~> Service[$service_name]
}
