# == Class: php::config
#
# Configure php.ini settings for a PHP SAPI
#
# === Parameters
#
# [*key*]
#   The php.ini settings key
#
# [*value*]
#   The php.ini setting value
#
# [*sapi*]
#   The PHP sapi (cli or apache2)
#
# === Variables
#
# No variables
#
# === Examples
#
#  php::config { "sample": key => 'PHP/short_open_tag', value => 'Off', 'sapi' => 'cli'; }
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
define php::config(
  $config_file,
  $config_changes
) {

  augeas { "php-${name}-config":
    context => "/files${config_file}",
    changes => template('php/augeas_commands.erb')
  }

}
