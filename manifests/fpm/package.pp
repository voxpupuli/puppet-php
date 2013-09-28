class php::fpm::package(
  $package_name     = $php::fpm::params::package,
  $package_ensure   = $php::fpm::params::ensure,
  $package_provider = $php::fpm::params::provider
) {

  package { $package_name:
    ensure   => $package_ensure,
    provider => $package_provider
  }
}
