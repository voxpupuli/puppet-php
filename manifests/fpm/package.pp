class php::fpm::package(
  $package_name     = $php::params::fpm_package,
  $package_ensure   = 'present',
) {

  package { $package_name:
    ensure   => $package_ensure,
  }
}
