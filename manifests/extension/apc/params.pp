# == Class: php::extension::apc::params
#
# Defaults file for the APC PHP extension
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
class php::extension::apc::params {

  $ensure         = $php::params::ensure
  $package        = 'php5-apc'
  $provider       = undef
  $config_file    = '/etc/php5/conf.d/20-apc.ini'
  $config_changes = {
    set => {
      '.anon/apc.enabled'           => 1,
      '.anon/apc.cache_by_default'  => 1,
      '.anon/apc.stat'              => 1,
      '.anon/apc.localcache'        => 1,
      '.anon/apc.localcache.size'   => 10000,
      '.anon/apc.shm_size'          => '64M',
      '.anon/apc.localcache'        => 1,
      '.anon/apc.localcache.size'   => 5000,
      '.anon/apc.apc.write_lock'    => 1,
      '.anon/apc.num_files_hint'    => 10000,
      '.anon/apc.user_entries_hint' => 40960,
      '.anon/apc.enable_cli'        => 0,
      '.anon/apc.file_update_protection' => 1,
      '.anon/apc.include_once_override' => 1
    }
  }

}
