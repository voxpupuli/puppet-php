# == Class: php::pecl::xdebug::package
#
# Install the PHP xdebug extension
#
# === Parameters
#
# [*version*]
#   The version of xdebug to install
#   Could be "latest", "installed" or a pinned verison
#
# [*package*]
#   The package name for xdebug
#   For debian it's php5-xdebug
#
# [*provider*]
#   The provider used to install php5-xdebug
#   Could be "pecl", "apt" or any other OS package provider
#
# === Variables
#
# No variables
#
# === Examples
#
#  include 'php::pecl::xdebug::package'
#
#  class {'php::pecl::xdebug::package':
#   version => latest
#  }
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::xdebug::package(
  $version  = $php::pecl::xdebug::params::version,
  $package  = $php::pecl::xdebug::params::package,
  $provider = $php::pecl::xdebug::params::provider
) inherits php::pecl::xdebug::params {

  php::pecl::package { 'xdebug':
    version  => $version,
    package  => $package,
    provider => $provider
  }

}
