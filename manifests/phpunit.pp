# == Class: php::phpunit
#
# Install phpunit, PHP testing framework via PEAR, this will be changed to use composer
#
# === Parameters
#
# [*package*]
#   The package name for PHPUnit, defaults to phpunit's pear package
#
# [*provider*]
#   The package provider used to install PHPUnit, defaults to pear
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
# Tobias Nyholm <tobias@happyrecruiting.se>
# Robin Gloster <robin.gloster@mayflower.de>
#
# === Copyright
#
# See LICENSE file
#

#FIXME: no pear
class php::phpunit (
  $package  = 'pear.phpunit.de/PHPUnit',
  $provider = 'pear',
) {

  if $caller_module_name != $module_name {
    warning("${name} is not part of the public API of the ${module_name} module and should not be directly included in the manifest.")
  }

  validate_string($package)

  package { $package:
    ensure    => present,
    provider  => $provider,
  }

  if $provider == 'pear' {
    Exec['php::pear::auto_discover'] -> Package[$package]
  }
}
