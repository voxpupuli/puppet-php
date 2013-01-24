# == Class: php::pecl::gearman::config
#
# Configure the PHP gearman extension
#
# === Parameters
#
# [*config_file*]
#   The path to the ini php5-gearman ini file
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
#  include php::pecl::gearman::config
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::gearman::config(
  $config_file    = $php::pecl::gearman::params::config_file,
  $config_changes = $php::pecl::gearman::params::config_changes
) inherits php::pecl::gearman::params {

  php::pecl::config { 'gearman':
    extension       => 'gearman',
    config_file     => $config_file,
    config_changes  => $config_changes
  }

}
