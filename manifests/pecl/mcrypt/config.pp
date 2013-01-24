# == Class: php::pecl::mcrypt::config
#
# Configure the PHP mcrypt extension
#
# === Parameters
#
# [*config_file*]
#   The path to the ini php5-mcrypt ini file
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
#  include php::pecl::mcrypt::config
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::mcrypt::config(
  $config_file    = $php::pecl::mcrypt::params::config_file,
  $config_changes = $php::pecl::mcrypt::params::config_changes
) inherits php::pecl::mcrypt::params {

  php::pecl::config { 'mcrypt':
    extension       => 'mcrypt',
    config_file     => $config_file,
    config_changes  => $config_changes
  }

}
