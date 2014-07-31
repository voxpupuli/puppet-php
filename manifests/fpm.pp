# == Class: php::fpm
#
# Install and configure mod_php for fpm
#
# === Parameters
#
# [*inifile*]
#   The path to the ini php5-fpm ini file
#
# [*settings*]
#   Nested hash of key => value to apply to php.ini
#
# [*user*]
#   user to run default FPM pool as
#
# [*group*]
#   group to run default FPM pool as
#
# [*pool_base_dir*]
#   The directory where to place FPM pool configs
#
# [*pools*]
#   Hash of php::fpm::pool resources that will be created. Defaults
#   to a single php::fpm::pool named www with default parameters.
#
# === Variables
#
# No variables
#
# === Examples
#
#  include php::fpm
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
class php::fpm(
  $pools = { 'www' => {} },
) {

  if $caller_module_name != $module_name {
    warning("${name} is not part of the public API of the ${module_name} module and should not be directly included in the manifest.")
  }

  validate_hash($pools)

  anchor { 'php::fpm::begin': } ->
    class { 'php::fpm::package': } ->
    class { 'php::fpm::config': }  ->
    class { 'php::fpm::service': } ->
  anchor { 'php::fpm::end': }

  $real_pools = hiera_hash('php::fpm::pools',  $pools)
  create_resources(php::fpm::pool, $real_pools)
}
