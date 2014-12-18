# == Class: php::packages
#
# Install common PHP packages
#
# === Parameters
#
# [*ensure*]
#   Specify which version of PHP packages to install
#
# [*names*]
#   List of the names of the package to install
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
  $ensure          = $php::ensure,
  $names_to_prefix = prefix($php::params::common_package_suffixes, $php::package_prefix),
  $names           = $php::params::common_package_names,
) inherits php::params {

  if $caller_module_name != $module_name {
    warning('php::packages is private')
  }

  validate_string($ensure)
  validate_array($names)
  validate_array($names_to_prefix)

  $real_names = union($names, $names_to_prefix)
  package { $real_names:
    ensure => $ensure,
  }
}
