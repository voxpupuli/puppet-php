# == Class: php::pecl::apc::config
#
# Configure the PHP APC extension
#
# === Parameters
#
# [*config_file*]
#   The path to the ini php5-apc ini file
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
#  include php::pecl::apc::config
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::apc::config(
  $config_file    = $php::pecl::apc::params::config_file,
  $config_changes = $php::pecl::apc::params::config_changes
) inherits php::pecl::apc::params {


}
