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
