# == Class: php::apache::config
#
# PHP apache SAPI configuration
#
# Wrapper for php::config which will change augeas settings in the right
# SAPI php.ini
#
# The *$name* of the php::apache::config call is used as key inside the
# augeas call. For list of valid values run augtool /files/etc/php5/apache/php.ini
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
#  php::apache::config { "PHP/short_open_tag": value => 'Off' }
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::apache::config(
  $config_file    = $php::apache::params::config_file,
  $config_changes = $php::apache::params::config_changes
) inherits php::apache::params {

  php::config { 'apache':
    config_file     => $config_file,
    config_changes  => $config_changes
  }

}
