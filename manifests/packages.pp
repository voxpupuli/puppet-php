# == Class: php::packages
#
# Install common PHP packages
#
# === Parameters
#
# [*ensure*]
#   Specify which version of PHP packages to install
#
# [*packages*]
#   List of packages to install
#
# === Authors
#
# Franz Pletz <franz.pletz@mayflower.de>
#
# === Copyright
#
# See LICENSE file
#

class php::packages (
  $ensure   = $php::ensure,
  $packages = $php::params::common_packages,
) inherits php::params {

  if $caller_module_name != $module_name {
    warning('php::packages is private')
  }

  validate_string($ensure)
  validate_array($packages)

  package { $packages:
    ensure => $ensure,
  }

}
