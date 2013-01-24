# == Class: php::pecl::http::package
#
# Install the PHP http extension
#
# === Parameters
#
# [*version*]
#   The version of http to install
#   Could be "latest", "installed" or a pinned verison
#
# [*package*]
#   The package name for http
#   For debian it's pecl_http
#
# [*provider*]
#   The provider used to install php5-http
#   Could be "pecl", "apt" or any other OS package provider
#
# === Variables
#
# No variables
#
# === Examples
#
#  include 'php::pecl::http::package'
#
#  class {'php::pecl::http::package':
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
class php::pecl::http::package(
  $version  = $php::pecl::http::params::version,
  $package  = $php::pecl::http::params::package,
  $provider = $php::pecl::http::params::provider
) inherits php::pecl::http::params {

  package { $required_packages:
  	ensure => installed;
  }

  php::pecl::package { 'http':
    version  => $version,
    package  => $package,
    provider => $provider,
    require	 => Package[$required_packages]
  }

}
