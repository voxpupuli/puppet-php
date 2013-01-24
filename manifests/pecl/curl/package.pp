# == Class: php::pecl::curl::package
#
# Install the PHP curl extension
#
# === Parameters
#
# [*version*]
#   The version of curl to install
#   Could be "latest", "installed" or a pinned verison
#
# [*package*]
#   The package name for curl
#   For debian it's php5-curl
#
# [*provider*]
#   The provider used to install php5-curl
#   Could be "pecl", "apt" or any other OS package provider
#
# === Variables
#
# No variables
#
# === Examples
#
#  include php::pecl::curl::package
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::curl::package(
  $version  = $php::pecl::curl::params::version,
  $package  = $php::pecl::curl::params::package,
  $provider = $php::pecl::curl::params::provider
) inherits php::pecl::curl::params {

  php::pecl::package { 'curl':
    version  => $version,
    package  => $package,
    provider => $provider
  }

}
