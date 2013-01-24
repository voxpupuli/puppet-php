# == Class: php::pecl::gd::package
#
# Install the PHP gd extension
#
# === Parameters
#
# [*version*]
#   The version of gd to install
#   Could be "latest", "installed" or a pinned verison
#
# [*package*]
#   The package name for gd
#   For debian it's php5-gd
#
# [*provider*]
#   The provider used to install php5-gd
#   Could be "pecl", "apt" or any other OS package provider
#
# === Variables
#
# No variables
#
# === Examples
#
#  include php::pecl::gd::package
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::gd::package(
  $version  = $php::pecl::gd::params::version,
  $package  = $php::pecl::gd::params::package,
  $provider = $php::pecl::gd::params::provider
) inherits php::pecl::gd::params {

  php::pecl::package { 'gd':
    version  => $version,
    package  => $package,
    provider => $provider
  }

}
