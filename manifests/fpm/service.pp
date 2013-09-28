class php::fpm::service(
  $service_name = $php::fpm::params::service_name,
  $ensure       = $php::fpm::params::service_ensure,
  $enable       = $php::fpm::params::service_enable,
  $has_status   = $php::fpm::params::service_has_status
) inherits php::fpm::params {

  service { $service_name:
    ensure    => $ensure,
    enable    => $enable,
    restart   => "service ${service_name} reload",
    hasstatus => $has_status,
    require   => Package[$package]
  }

}
