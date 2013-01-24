# == Class: php::pecl::imagick::package
#
# Install the PHP imagick extension
#
# === Parameters
#
# [*version*]
#   The version of imagick to install
#   Could be "latest", "installed" or a pinned verison
#
# [*package*]
#   The package name for imagick
#   For debian it's php5-imagick
#
# [*provider*]
#   The provider used to install php5-imagick
#   Could be "pecl", "apt" or any other OS package provider
#
# === Variables
#
# No variables
#
# === Examples
#
#  include 'php::pecl::imagick::package'
#
#  class {'php::pecl::imagick::package':
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
class php::pecl::imagick::package(
  $version  = $php::pecl::imagick::params::version,
  $package  = $php::pecl::imagick::params::package,
  $provider = $php::pecl::imagick::params::provider
) inherits php::pecl::imagick::params {

  php::pecl::package { 'imagick':
    version  => $version,
    package  => $package,
    provider => $provider
  }

}
