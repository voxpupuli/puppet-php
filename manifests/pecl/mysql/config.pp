# == Class: php::pecl::mysql::config
#
# Configure the PHP mysql extension
#
# === Parameters
#
# [*config_file*]
#   The path to the ini php5-mysql ini file
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
#  include php::pecl::mysql::config
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::mysql::config(
  $config_file    = $php::pecl::mysql::params::config_file,
  $config_changes = $php::pecl::mysql::params::config_changes
) inherits php::pecl::mysql::params {

  php::pecl::config { 'mysql':
    extension       => 'mysql',
    config_file     => $config_file,
    config_changes  => $config_changes
  }

}
