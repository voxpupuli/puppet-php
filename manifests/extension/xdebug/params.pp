# == Class: php::extension::xdebug::params
#
# Defaults file for the xdebug PHP extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*ensure*]
#   The version of the package to install
#   Could be "latest", "installed" or a pinned version
#   This matches "ensure" from Package
#
# [*package*]
#   The package name in your provider
#
# [*provider*]
#   The provider used to install the package
#
# [*install_dir*]
#   The path of the installed xdebug.so binary
#
# [*inifile*]
#   The path to the extension ini file
#
# [*settings*]
#   Hash with 'set' nested hash of key => value
#   set changes to agues when applied to *inifile*
#
# === Examples
#
# No examples
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
class php::extension::xdebug::params {

  $ensure      = $php::params::ensure
  $package     = 'php5-xdebug'
  $provider    = undef
  $install_dir = '/usr/lib/php5/20121212'
  $inifile     = '/etc/php5/conf.d/xdebug.ini'
  $settings = {
    set => {
      '.anon/zend_extension' => "${install_dir}/xdebug.so",
      '.anon/xdebug.max_nesting_level' => '1000'
    }
  }

}
