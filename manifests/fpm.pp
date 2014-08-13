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
#
# === Copyright
#
# See LICENSE file
#
class php::fpm(
  $inifile  = $php::params::fpm_inifile,
  $user     = $php::params::fpm_user,
  $group    = undef,
  $settings = {},
  $pools    = { 'www' => {} },
) inherits php::params {

  if $caller_module_name != $module_name {
    warning("${name} is not part of the public API of the ${module_name} module and should not be directly included in the manifest.")
  }

  validate_string($inifile)
  validate_string($user)
  validate_string($group)
  validate_hash($settings)
  validate_hash($pools)

  anchor { 'php::fpm::begin': } ->
    class { 'php::fpm::package': } ->
    php::fpm::config { 'php-fpm':
      file    => $inifile,
      config  => $settings
    } ->
    class { 'php::fpm::service': } ->
  anchor { 'php::fpm::end': }

  create_resources(php::fpm::pool, $pools)
}
