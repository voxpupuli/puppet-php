# == Class: php::pecl::ssh2::config
#
# Configure the PHP ssh2 extension
#
# === Parameters
#
# [*config_file*]
#   The path to the ini php5-ssh2 ini file
#
# [*config_changes*]
#	Hash with 'set' nested hash of key => value
#	set changes to agues when applied to *config_file*
#
# === Variables
#
# No variables
#
# === Examples
#
#  include php::pecl::ssh2::config
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::ssh2::config(
  $config_file    = $php::pecl::ssh2::params::config_file,
  $config_changes = $php::pecl::ssh2::params::config_changes
) inherits php::pecl::ssh2::params {

  php::pecl::config { 'ssh2':
    extension       => 'ssh2',
    config_file     => $config_file,
    config_changes  => $config_changes
  }

}
