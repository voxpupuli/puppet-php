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
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
define php::config(
  $inifile,
  $settings
) {

  include php::augeas

  augeas { "php-${name}-config":
    context   => "/files${inifile}",
    load_path => '/usr/share/augeas/lenses/contrib/',
    changes   => template('php/augeas_commands.erb'),
    require   => Class['php::augeas']
  }

}
