# == Class: php::augeas
#
# php augeas class
#
# Ensure that the php augeas lense is loaded
#
# This lense supports php fpm format
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
#  include php::augeas
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# See LICENSE file
#
class php::augeas (
  $augeas_contrib_dir = $php::params::augeas_contrib_dir,
) inherits php::params {

  if $caller_module_name != $module_name {
    warning("${name} is not part of the public API of the ${module_name} module and should not be directly included in the manifest.")
  }

  if !defined(File[$augeas_contrib_dir]) {
    file { $augeas_contrib_dir:
      ensure  => directory,
      recurse => true,
      purge   => true,
      force   => true,
      mode    => '0644',
      owner   => 'root',
      group   => 'root'
    }
  }

  file { "${augeas_contrib_dir}/php.aug":
    ensure  => present,
    source  => 'puppet:///modules/php/php.aug',
    require => File[$augeas_contrib_dir]
  }
}
