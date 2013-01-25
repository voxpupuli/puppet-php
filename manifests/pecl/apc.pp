# == Class: php::pecl::apc
#
# Install and configure the APC PHP extension
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*php_version*]
#   The version of apc to install
#
# === Examples
#
#  include php::pecl::apc
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::apc(
  $version        = $php::params::version,
  $package        = $php::pecl::apc::params::package,
  $provider       = $php::pecl::apc::params::provider,
  $config_file    = $php::pecl::apc::params::config_file,
  $config_changes = $php::pecl::apc::params::config_changes
) inherits php::pecl::apc::params {

  php::pecl::package { 'apc':
    version  => $version,
    package  => $package,
    provider => $provider
  }

  php::pecl::config { 'apc':
    extension      => 'apc',
    config_file    => $config_file,
    config_changes => $config_changes
  }

}
