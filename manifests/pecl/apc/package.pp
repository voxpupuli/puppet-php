# == Class: php::pecl::apc::package
#
# Install the PHP APC extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*php_version*]
#   The version of APC to install
#
# === Examples
#
#  include php::pecl::apc::package
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
  $version        = $php::pecl::apc::params::version,
  $package        = $php::pecl::apc::params::package,
  $provider       = $php::pecl::apc::params::provider,
  $require        = $php::pecl::apc::params::require,
  $notify         = $php::pecl::apc::params::notify
) inherits php::pecl::apc::params {

  php::pecl::package { 'apc':
    version  => $version,
    package  => $package,
    provider => $provider,
    require  => $require,
    notify   => $notify
  }

}
