# This class only checks if the shipped php version matches the requested one.
# no repo setup has to be done here.
#
# === Parameters
# [*version_matrix*]
#   Lookup matrix to map Debian Versions to their shipped Php Versions.
#
class php::repo::debian::native(
  Hash $version_matrix,
) {
  if $caller_module_name != $module_name {
    warning('php::repo::debian is private')
  }

  if $version_matrix[$facts['os']['release']['major']] != $php::globals::globals_php_version {
    fail("invalid version php '${php::globals::globals_php_version}' in native mode for current operation system version
      (debian${facts['os']['release']['major']}). valid version is ${version_matrix[$facts['os']['release']['major']]}")
  }
}
