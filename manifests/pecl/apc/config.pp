# == Class: php::pecl::apc::config
#
# Configure the PHP APC extension
#
# === Parameters
#
# No parameters
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

  php::pecl::config { 'apc':
    extension       => 'apc',
    config_file     => $config_file,
    config_changes  => $config_changes
  }

}
