# == Class: php::apache
#
# Install and configure mod_php for apache
#
# === Parameters
#
# [*ensure*]
#   The ensure of the apache package to install
#   Could be "latest", "installed" or a pinned verison
#
# [*package*]
#   The package name for apache module package
#
# [*inifile*]
#   The path to the apache ini file
#
# [*settings*]
#   Nested hash of key => value to apply to php.ini
#
# [*service_name*]
#   Service to notify after installation or change
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
class php::apache(
  $ensure       = 'installed',
  $package      = $php::params::apache_package,
  $inifile      = $php::params::apache_inifile,
  $settings     = {},
  $service_name = $php::params::apache_service_name
) inherits php::params {

  if $caller_module_name != $module_name {
    warning("${name} is not part of the public API of the ${module_name} module and should not be directly included in the manifest.")
  }

  package { $package:
    ensure   => $ensure,
  }

  php::config { 'apache':
    file   => $inifile,
    config => $settings,
    notify => Service[$service_name],
  }

  Php::Extension <| |> ~> Service[$service_name]
}
