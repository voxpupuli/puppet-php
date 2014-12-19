# == Class: php::fpm::service
#
# Configure fpm service
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
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
# Robin Gloster <robin.gloster@mayflower.de>
#
# === Copyright
#
# See LICENSE file
#
class php::fpm::service(
  $service_name = $php::params::fpm_service_name,
  $ensure       = 'running',
  $enable       = $php::params::fpm_service_enable,
) inherits php::params {

  if $caller_module_name != $module_name {
    warning('php::fpm::service is private')
  }

  service { $service_name:
    ensure    => $ensure,
    enable    => $enable,
    restart   => "service ${service_name} reload",
    hasstatus => true,
  }

  Php::Extension <| |> ~> Service[$service_name]
}
