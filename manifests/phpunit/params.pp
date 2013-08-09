# == Class: php::phpunit::params
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
#   For debian it's pear.phpunit.de/PHPUnit
#
# [*provider*]
#   The provider used to install pear.phpunit.de/PHPUnit
#   Could be "pecl", "apt" or any other OS package provider
#
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
# Tobias Nyholm <tobias@happyrecruiting.se>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::phpunit::params {

  $ensure   = $php::params::ensure
  $package  = 'pear.phpunit.de/PHPUnit'
  $provider = 'pear'

}
