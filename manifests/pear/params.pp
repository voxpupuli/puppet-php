# == Class: php::pear::params
#
# Defaults file for pear package
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*ensure*]
#   The ensure of the pear package to install
#   Could be "latest", "installed" or a pinned verison
#
# [*package*]
#   The package name for pear package
#   For debian it's php5-pear
#
# [*provider*]
#   The provider used to install php5-pear
#   Could be "pecl", "apt" or any other OS package provider
#
# [*inifile*]
#   The path to the ini php5-pear ini file
#
# [*settings*]
#   Hash with 'set' nested hash of key => value
#   set changes to agues when applied to *inifile*
#
# === Examples
#
#  include 'php::pear::package'
#
#  class {'php::pear::package
#   ensure => latest
#  }
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
class php::pear::params {

  $ensure   = $php::params::ensure
  $package  = 'php-pear'
  $provider = undef

}
