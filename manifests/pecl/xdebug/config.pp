# == Class: php::pecl::xdebug::config
#
# Configure the PHP xdebug extension
#
# === Parameters
#
# [*config_file*]
#   The path to the ini php5-xdebug ini file
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
#  include php::pecl::xdebug::config
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::xdebug::config(
  $config_file    = $php::pecl::xdebug::params::config_file,
  $config_changes = $php::pecl::xdebug::params::config_changes
) inherits php::pecl::xdebug::params {

  php::pecl::config { 'xdebug':
    extension       => 'xdebug',
    config_file     => $config_file,
    config_changes  => $config_changes
  }

}
