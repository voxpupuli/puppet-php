# == Class: php::pecl::apc::package
#
# Install the PHP APC extension
#
# === Parameters
#
# [*version*]
#   The version of APC to install
#   Could be "latest", "installed" or a pinned verison
#
# [*package*]
#   The package name for apc
#   For debian it's php5-apc
#
# [*provider*]
#   The provider used to install php5-apc
#   Could be "pecl", "apt" or any other OS package provider
#
# === Variables
#
# No variables
#
# === Examples
#
#  include 'php::pecl::apc::package'
#
#  class {'php::pecl::apc::package':
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
class php::pecl::apc::package(
  $version  = $php::pecl::apc::params::version,
  $package  = $php::pecl::apc::params::package,
  $provider = $php::pecl::apc::params::provider
) inherits php::pecl::apc::params {

  php::pecl::package { 'apc':
    version  => $version,
    package  => $package,
    provider => $provider
  }

}
