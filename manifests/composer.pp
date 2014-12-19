# == Class: php::composer
#
# Install composer package manager
#
# === Parameters
#
# [*source*]
# Holds URL to the Composer source file
#
# [*path*]
# Holds path to the Composer executable
#
# [*auto_update*]
# defines if composer should be auto updated
#
# [*max_age*]
# defines the time in days after which an auto-update gets executed
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
    warning('php::composer is private')
  }

  validate_string($source)
  validate_absolute_path($path)
  validate_bool($auto_update)
  validate_re("x${max_age}", '^x\d+$')

  exec { 'download composer':
    command => "wget ${source} -O ${path}",
    creates => $path,
    path    => ['/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/'],
    require => Class['php::cli'],
  } ->
  file { $path:
    mode  => '0555',
    owner => root,
    group => root,
  }

  if $auto_update {
    class { 'php::composer::auto_update':
      max_age => $max_age,
      source  => $source,
      path    => $path
    }
  }
}
