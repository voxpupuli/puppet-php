# == Class: php::pecl::curl::config
#
# Configure the PHP curl extension
#
# === Parameters
#
# [*config_file*]
#   The path to the ini php5-curl ini file
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
#  include php::pecl::curl::config
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::curl::config(
  $config_file    = $php::pecl::curl::params::config_file,
  $config_changes = $php::pecl::curl::params::config_changes
) inherits php::pecl::curl::params {

  php::pecl::config { 'curl':
    extension       => 'curl',
    config_file     => $config_file,
    config_changes  => $config_changes
  }

}
