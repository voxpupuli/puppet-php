# == Class: php::pecl::uploadprogress::config
#
# Configure the PHP uploadprogress extension
#
# === Parameters
#
# [*config_file*]
#   The path to the ini php5-uploadprogress ini file
#
# [*config_changes*]
# Hash with 'set' nested hash of key => value
# set changes to agues when applied to *config_file*
#
# === Variables
#
# No variables
#
# === Examples
#
#  include php::pecl::uploadprogress::config
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::uploadprogress::config(
  $config_file    = $php::pecl::uploadprogress::params::config_file,
  $config_changes = $php::pecl::uploadprogress::params::config_changes
) inherits php::pecl::uploadprogress::params {

  php::pecl::config { 'uploadprogress':
    extension       => 'uploadprogress',
    config_file     => $config_file,
    config_changes  => $config_changes
  }

}
