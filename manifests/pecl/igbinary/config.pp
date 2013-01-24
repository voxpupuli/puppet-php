# == Class: php::pecl::igbinary::config
#
# Configure the PHP igbinary extension
#
# === Parameters
#
# [*config_file*]
#   The path to the ini php5-igbinary ini file
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
#  include php::pecl::igbinary::config
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::igbinary::config(
  $config_file    = $php::pecl::igbinary::params::config_file,
  $config_changes = $php::pecl::igbinary::params::config_changes
) inherits php::pecl::igbinary::params {

  php::pecl::config { 'igbinary':
    extension       => 'igbinary',
    config_file     => $config_file,
    config_changes  => $config_changes
  }

}
