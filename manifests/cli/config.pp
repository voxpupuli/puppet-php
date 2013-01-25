# == Class: php::cli::config
#
# PHP cli SAPI configuration
#
# Wrapper for php::config which will change augeas settings in the right
# SAPI php.ini
#
# The *$name* of the php::cli::config call is used as key inside the
# augeas call. For list of valid values run augtool /files/etc/php5/cli/php.ini
#
# === Parameters
#
# [*value*]
#   The php.ini setting value
#
# === Variables
#
# No variables
#
# === Examples
#
#  php::cli::config { "PHP/short_open_tag": value => 'Off' }
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::cli::config(
  $config_file    = $php::cli::params::config_file,
  $config_changes = $php::cli::params::config_changes
) inherits php::cli::params {

  php::config { "cli-${name}":
    config_file     => $config_file,
    config_changes  => $config_changes
  }

}
