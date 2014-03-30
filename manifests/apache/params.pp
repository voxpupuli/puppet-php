# == Class: php::apache::params
#
# Defaults file for apache package
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
#   The package name for apache package
#
# [*provider*]
#   The provider used to install package
#
# [*inifile*]
#   The path to the ini php5 apache ini file
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
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
class php::apache::params {

  $ensure   = $php::params::ensure
  $package  = 'libapache2-mod-php5'
  $provider = undef
  $inifile  = '/etc/php5/apache2/php.ini'
  $settings = [ ]

  $service_name = 'apache2'

}
