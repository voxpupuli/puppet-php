# == Class: php::config
#
# Configure php.ini settings for a PHP SAPI
#
# === Parameters
#
# [*file*]
#   The path to ini file
#
# [*config*]
#   Nested hash of key => value to apply to php.ini
#
# === Variables
#
# No variables
#
# === Examples
#
# php::config { '$unique-name':
#   file  => '$full_path_to_ini_file'
#   config => {
#     {'Date/date.timezone' => 'Europe/Berlin'}
#   }
# }
#
# === Authors
#
# Robin Gloster <robin.gloster@mayflower.de>
#
# === Copyright
#
# See LICENSE file
#
define php::config(
  $file,
  $config
) {

  if $caller_module_name != $module_name {
    warning("${name} is not part of the public API of the ${module_name} module and should not be directly included in the manifest.")
  }

  validate_hash($config)

  create_resources(config::setting, to_hash_settings($config, $file), {
    file => $file
  })
}
