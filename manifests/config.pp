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
# === Examples
#
#   php::config { '$unique-name':
#     file  => '$full_path_to_ini_file'
#     config => {
#       {'Date/date.timezone' => 'Europe/Berlin'}
#     }
#   }
#
define php::config(
  Stdlib::Absolutepath $file,
  Optional[Hash] $config
) {

  if $caller_module_name != $module_name {
    warning('php::config is private')
  }

  if (undef != $config) {
    create_resources(::php::config::setting, to_hash_settings($config, $file), {
      file => $file
    })
  }
  else {
    create_resources(::php::config::setting, to_hash_settings($file), {
      file => $file
    })    
  }
}
