# == Class: php::pecl::http::config
#
# Configure the PHP http extension
#
# === Parameters
#
# [*config_file*]
#   The path to the ini php5-http ini file
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
#  include php::pecl::http::config
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::http::config(
  $config_file    = $php::pecl::http::params::config_file,
  $config_changes = $php::pecl::http::params::config_changes
) inherits php::pecl::http::params {

  php::pecl::config { 'http':
    extension       => 'http',
    config_file     => $config_file,
    config_changes  => $config_changes
  }

}
