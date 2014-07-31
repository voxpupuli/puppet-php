# == php::config::setting
#
# Configure php.ini settings
#
# === Parameters
#
# [*file*]
#   The path to ini file
#
# [*value*]
#   The value to set
#
# === Examples
#
# php::config::setting { 'Date/date.timezone':
#   file  => '$full_path_to_ini_file'
#   value => 'Europe/Berlin'
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
define php::config::setting(
  $value,
  $file,
) {

  if $caller_module_name != $module_name {
    warning("${name} is not part of the public API of the ${module_name} module and should not be directly included in the manifest.")
  }

  validate_string($file)

  $split_name = split($name, '/')
  if count($split_name) == 1 {
    $section = ''
    $setting = $split_name[0]
  } else {
    $section = $split_name[0]
    $setting = $split_name[1]
  }

  ini_setting { $name:
    value   => $value,
    path    => $file,
    section => $section,
    setting => $setting
  }
}
