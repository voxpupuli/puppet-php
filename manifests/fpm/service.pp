class php::fpm::service(
  $service_name = $php::params::fpm_service_name,
  $ensure       = present,
  $enable       = $php::fpm_service_enable,
) inherits php::params {

  service { $service_name:
    ensure    => $ensure,
    enable    => $enable,
    restart   => "service ${service_name} reload",
    hasstatus => true,
    require   => Package[$php::params::fpm_package],
  }

  Php::Extension <| |> ~> Service[$service_name]
}
