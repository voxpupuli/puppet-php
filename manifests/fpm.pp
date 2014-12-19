# == Class: php::fpm
#
# Install and configure mod_php for fpm
#
# === Parameters
#
# [*pools*]
#   Hash of php::fpm::pool resources that will be created. Defaults
#   to a single php::fpm::pool named www with default parameters.
#
# === Authors
#
# Robin Gloster <robin.gloster@mayflower.de>
# Franz Pletz <franz.pletz@mayflower.de>
#
# === Copyright
#
# See LICENSE file
#
class php::fpm (
  $ensure   = $php::ensure,
  $package  = "${php::package_prefix}${php::params::fpm_package_suffix}",
  $inifile  = $php::params::fpm_inifile,
  $settings = {},
  $pools    = { 'www' => {} },
) inherits php::params {

  if $caller_module_name != $module_name {
    warning('php::fpm is private')
  }

  validate_string($ensure)
  validate_string($package)
  validate_absolute_path($inifile)
  validate_hash($settings)
  validate_hash($pools)

  $real_settings = deep_merge($settings, hiera_hash('php::fpm::settings', {}))

  anchor { 'php::fpm::begin': } ->
    package { $package:
      ensure  => $ensure,
      require => Class['php::packages'],
    } ->
    class { 'php::fpm::config':
      inifile  => $inifile,
      settings => $real_settings,
    } ->
    class { 'php::fpm::service': } ->
  anchor { 'php::fpm::end': }

  $real_pools = hiera_hash('php::fpm::pools',  $pools)
  create_resources(php::fpm::pool, $real_pools)
}
