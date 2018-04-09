# Allows to define a custom repository as php install source.
#
# === Parameters
# [*apt_source*]
#   Hash holding all parameters passed directly to `apt::source`.
#
# [*apt_list_name*]
#   Allows to customize the list name used in `/etc/apt/sources.list.d/YOUR_LIST_NAME.list`.
#
class php::repo::debian::dotdeb(
  Hash $apt_source,
  String $apt_list_name,
  Hash $version_matrix,
) {
  if $caller_module_name != $module_name {
    warning('php::repo::debian is private')
  }

  if ! ($php::globals::globals_php_version in $version_matrix[$facts['os']['release']['major']]) {
    $available_versions = join($version_matrix[$facts['os']['release']['major']], ", ")
    fail("invalid version php '${php::globals::globals_php_version}' in dotdeb mode for current operation system version
      (debian${facts['os']['release']['major']}). valid versions are '${$available_versions}'")
  }

  apt::source { $apt_list_name:
    * => $apt_source,
  }
}
