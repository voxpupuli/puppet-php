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
#   An array of augeas commands to execute
#
# === Variables
#
# No variables
#
# === Examples
#
# php::config { '$unique-name':
#   file  => '$full_path_to_ini_file'
#   config => [
#     'set .anon/apc.enabled 1'
#   ]
# }
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
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

  validate_array($config)

  include php::params

  include php::augeas

  augeas { "php-${name}-config":
    incl      => $file,
    changes   => $config,
    load_path => $::php::params::augeas_contrib_dir,
    lens      => 'PHP.lns',
    require   => Class['php::augeas']
  }
}
