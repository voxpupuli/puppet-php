# == Class: php::composer
#
# Install composer package manager
#
# === Parameters
#
# [*source*]
# Holds URL to the Composer source file
#
# [*destination*]
# Holds path to the Composer executable
#
# === Variables
#
# No variables
#
# === Examples
#
#  include php::composer
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
# Robin Gloster <robin.gloster@mayflower.de>
#
# === Copyright
#
# See LICENSE file
#
class php::composer (
  $source      = $php::params::composer_source,
  $path        = $php::params::composer_path,
  $auto_update = true,
  $max_age     = $php::params::composer_max_age,
) inherits php::params {

  if $caller_module_name != $module_name {
    warning("${name} is not part of the public API of the ${module_name} module and should not be directly included in the manifest.")
  }

  exec { 'download composer':
    command => "wget ${source} -O ${path}",
    creates => $path,
    path    => ['/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/'],
    require => [
      Package[$php::cli::params::package]
    ]
  } ->
  file { $path:
    mode    => '0555',
    owner   => root,
    group   => root,
  }

  if $auto_update {
    class {'php::composer::auto_update':
      max_age => $max_age,
      source  => $source,
      path    => $path
    }
  }
}
