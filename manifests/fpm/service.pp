# == Class: php::fpm::service
#
# Configure fpm service
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
class php::fpm::service(
  $service_name = $php::params::fpm_service_name,
  $ensure       = 'running',
  $enable       = $php::fpm_service_enable,
) inherits php::params {

  if $caller_module_name != $module_name {
    warning("${name} is not part of the public API of the ${module_name} module and should not be directly included in the manifest.")
  }

  service { $service_name:
    ensure    => $ensure,
    enable    => $enable,
    restart   => "service ${service_name} reload",
    hasstatus => true,
    require   => Package[$php::params::fpm_package],
  }

  Php::Extension <| |> ~> Service[$service_name]
}
