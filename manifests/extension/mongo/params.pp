# == Class: php::extension::mongo::params
#
# Defaults file for the mongo PHP extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*ensure*]
#   The version of the package to install
#   Could be "latest", "installed" or a pinned version
#   This matches "ensure" from Package
#
# [*package*]
#   The package name in your provider
#
# [*provider*]
#   The provider used to install the package
#
# [*inifile*]
#   The path to the extension ini file
#
# [*settings*]
#   Hash with 'set' nested hash of key => value
#   set changes to agues when applied to *inifile*
#
# === Examples
#
# No examples
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
# Davide "SbiellONE" Bellettini <davide@bellettini.me>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
class php::extension::mongo::params {

  $ensure   = $php::params::ensure
  $package  = 'mongo'
  $provider = 'pecl'
  $inifile  = "${php::params::config_root_ini}/mongo.ini"
  $settings = [
    'set ".anon/extension" "mongo.so"'
  ]

}
