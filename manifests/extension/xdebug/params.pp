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
# [*config_file*]
#   The path to the extension ini file
#
# [*config_changes*]
#   Hash with 'set' nested hash of key => value
#   set changes to agues when applied to *config_file*
#
# === Examples
#
# No examples
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::extension::xdebug::params {

  $ensure         = $php::params::ensure
  $package        = 'php5-xdebug'
  $provider       = undef
  $install_dir	  = '/usr/lib/php5/20100525'
  $config_file    = '/etc/php5/conf.d/xdebug.ini'
  $config_changes = {
    set => {
    	'.anon/zend_extension' => "${install_dir}/xdebug.so",
    	'.anon/xdebug.max_nesting_level' => '1000'
    }
  }

}
