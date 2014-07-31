# == Class: php::fpm::package
#
# Configure fpm package
#
# === Parameters
#
# No parameters
#
# === Variables
#
# No variables
#
# === Examples
#
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
class php::fpm::package(
  $package_name   = $php::params::fpm_package,
  $package_ensure = 'installed',
) inherits php::params {

  if $caller_module_name != $module_name {
    warning("${name} is not part of the public API of the ${module_name} module and should not be directly included in the manifest.")
  }

  package { $package_name:
    ensure => $package_ensure,
  }
}
