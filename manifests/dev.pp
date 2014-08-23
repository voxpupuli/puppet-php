# == Class: php::dev
#
# PHP dev package
#
# Install the development headers for PHP
#
# === Parameters
#
# [*ensure*]
#   The PHP ensure of PHP dev to install
#
# [*package*]
#   The package name for PHP dev
#   For debian it's php5-dev
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
class php::dev(
  $ensure   = 'installed',
  $package  = $php::params::dev_package,
) inherits php::params {


  if $caller_module_name != $module_name {
    warning("${name} is not part of the public API of the ${module_name} module and should not be directly included in the manifest.")
  }

  package { $package:
    ensure   => $ensure,
  }
}
