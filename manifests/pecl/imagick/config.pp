# == Class: php::pecl::imagick::config
#
# Configure the PHP imagick extension
#
# === Parameters
#
# [*config_file*]
#   The path to the ini php5-imagick ini file
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
#  include php::pecl::imagick::config
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::imagick::config(
  $config_file    = $php::pecl::imagick::params::config_file,
  $config_changes = $php::pecl::imagick::params::config_changes
) inherits php::pecl::imagick::params {

  php::pecl::config { 'imagick':
    extension       => 'imagick',
    config_file     => $config_file,
    config_changes  => $config_changes
  }

}
