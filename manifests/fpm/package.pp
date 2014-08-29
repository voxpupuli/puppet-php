# == Class: php::fpm::package
#
# Configure fpm package
#
# === Parameters
#
# [*package_name*]
#   The name of the php-fpm package
#
# [*package_ensure*]
#   Status of the package
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
  $package_ensure = $php::ensure,
  $package_name   = $php::params::fpm_package,
) inherits php::params {

  if $caller_module_name != $module_name {
    warning("${name} is not part of the public API of the ${module_name} module and should not be directly included in the manifest.")
  }

  package { $package_name:
    ensure => $package_ensure,
  }
}
