# == Class: php::cli::config
#
# Configure php.ini settings for a PHP SAPI
#
# === Parameters
#
# [*inifile*]
#   The path to ini file
#
# [*settings*]
#   The hash having key => values pairs to change
#
# === Variables
#
# No variables
#
# === Examples
#
# TODO
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
define php::cli::config(
  $file     = $php::cli::params::inifile,
  $config   = []
) {

  php::config { $name:
    file      => $file,
    config    => $config
  }

}
