# == Class: php::phpunit::auto_update
#
# Install phpunit package manager
#
# === Parameters
#
# [*max_age*]
# Defines number of days after which phpunit should be updated
#
# [*source*]
# Holds URL to the phpunit source file
#
# [*path*]
# Holds path to the phpunit executable
#
# === Examples
#
#  include php::phpunit::auto_update
#  class { "php::phpunit::auto_update":
#    "max_age" => 90
#  }
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
class php::phpunit::auto_update (
  $max_age,
  $source,
  $path,
) {

  if $caller_module_name != $module_name {
    warning("${name} is not part of the public API of the ${module_name} module and should not be directly included in the manifest.")
  }

  exec { 'update phpunit':
    command => "wget ${source} -O ${path}",
    onlyif  => "test `find '${path}' -mtime +${max_age}`",
    path    => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
    require => File[$path],
  }
}
