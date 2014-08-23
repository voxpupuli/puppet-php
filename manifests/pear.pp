# == Class: php::pear
#
# Install PEAR package manager
#
# === Parameters
#
# [*ensure*]
#   The PHP ensure of PHP pear to install and run pear auto_discover
#
# [*package*]
#   The package name for PHP pear
#   For debian it's php5-pear
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
class php::pear(
  $ensure   = 'installed',
  $package  = $php::params::pear_package,
) inherits php::params {

  if $caller_module_name != $module_name {
    warning("${name} is not part of the public API of the ${module_name} module and should not be directly included in the manifest.")
  }

  validate_string($ensure)
  validate_string($package)

  package { $package:
    ensure   => $ensure,
  }

  exec { 'php::pear::auto_discover':
    command => 'pear config-set auto_discover 1 system',
    unless  => 'pear config-get auto_discover system | grep -q 1',
    path    => ['/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/'],
    require => Package[$package],
  }
}
