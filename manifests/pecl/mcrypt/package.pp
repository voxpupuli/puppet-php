# == Class: php::pecl::mcrypt::package
#
# Install the PHP mcrypt extension
#
# === Parameters
#
# [*version*]
#   The version of mcrypt to install
#   Could be "latest", "installed" or a pinned verison
#
# [*package*]
#   The package name for mcrypt
#   For debian it's php5-mcrypt
#
# [*provider*]
#   The provider used to install php5-mcrypt
#   Could be "pecl", "apt" or any other OS package provider
#
# === Variables
#
# No variables
#
# === Examples
#
#  include 'php::pecl::mcrypt::package'
#
#  class {'php::pecl::mcrypt::package':
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
class php::pecl::mcrypt::package(
  $version  = $php::pecl::mcrypt::params::version,
  $package  = $php::pecl::mcrypt::params::package,
  $provider = $php::pecl::mcrypt::params::provider
) inherits php::pecl::mcrypt::params {

  php::pecl::package { 'mcrypt':
    version  => $version,
    package  => $package,
    provider => $provider
  }

}
