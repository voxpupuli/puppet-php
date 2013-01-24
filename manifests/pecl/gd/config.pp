# == Class: php::pecl::gd::config
#
# Configure the PHP gd extension
#
# === Parameters
#
# [*config_file*]
#   The path to the ini php5-gd ini file
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
#  include php::pecl::gd::config
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::gd::config(
  $config_file    = $php::pecl::gd::params::config_file,
  $config_changes = $php::pecl::gd::params::config_changes
) inherits php::pecl::gd::params {

  php::pecl::config { 'gd':
    extension       => 'gd',
    config_file     => $config_file,
    config_changes  => $config_changes
  }

}
