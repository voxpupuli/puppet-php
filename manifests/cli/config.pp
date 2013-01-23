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
define php::cli::config($value) {

  $notify = [

  ]

  $require = [
    Package['php5-cli']
  ]

  php::config { "cli/${name}":
    sapi    => 'cli',
    notify  => $notify,
    require => $require,
    key     => $name,
    value   => $value;
  }

}
