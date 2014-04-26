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
# Copyright 2012-2014 Christian "Jippi" Winther, unless otherwise noted.
#
define php::config(
  $file,
  $config
) {

  validate_array($config)

  include php::augeas
  include php::params

  augeas { "php-${name}-config":
    incl      => $file,
    changes   => $config,
    load_path => $::php::params::augeas_contrib_dir,
    lens      => 'PHP.lns',
    require   => Class['php::augeas']
  }
}
