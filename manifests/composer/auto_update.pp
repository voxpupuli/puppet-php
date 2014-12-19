# == Class: php::composer::auto_update
#
# Install composer package manager
#
# === Parameters
#
# [*max_age*]
# Defines number of days after which Composer should be updated
#
# [*source*]
# Holds URL to the Composer source file
#
# [*path*]
# Holds path to the Composer executable
#
# === Examples
#
#  include php::composer::auto_update
#  class { "php::composer::auto_update":
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
class php::composer::auto_update (
  $max_age,
  $source,
  $path,
) {

  if $caller_module_name != $module_name {
    warning('php::composer::auto_update is private')
  }

  exec { 'update composer':
    command => "wget ${source} -O ${path}",
    onlyif  => "test `find '${path}' -mtime +${max_age}`",
    path    => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
    require => File[$path],
  }
}
