# == Class: php::extension::imagick
#
# Install and configure the imagick PHP extension
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
# [*config_file*]
#   The path to the ini php5-imagick ini file
#
# [*config_changes*]
#	Hash with 'set' nested hash of key => value
#	set changes to agues when applied to *config_file*
#
# === Variables
#
# [*php_version*]
#   The version of imagick to install
#
# === Examples
#
#  include php::extension::imagick
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::extension::imagick(
  $version  			= $php::extension::imagick::params::version,
  $package  			= $php::extension::imagick::params::package,
  $provider 			= $php::extension::imagick::params::provider,
  $config_file    = $php::extension::imagick::params::config_file,
  $config_changes = $php::extension::imagick::params::config_changes
) inherits php::extension::imagick::params {

  php::extension { 'imagick':
    version  => $version,
    package  => $package,
    provider => $provider
  }

  php::config { 'php-extension-imagick':
    config_file     => $config_file,
    config_changes  => $config_changes
  }

}
