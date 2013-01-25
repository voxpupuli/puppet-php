# == Class: php::cli
#
# Install and configure php CLI
#
# === Parameters
#
# [*ensure*]
#   The PHP ensure of PHP CLI to install
#
# [*package*]
#   The package name for PHP CLI
#   For debian it's php5-cli
#
# [*provider*]
#   The provider used to install php5-cli
#   Could be "pecl", "apt" or any other OS package provider
#
# [*config_file*]
#   The path to the ini php5-cli ini file
#
# [*config_changes*]
#   Hash with 'set' nested hash of key => value
#   set changes to agues when applied to *config_file*
#
# === Variables
#
# No variables
#
# === Examples
#
#  include php::cli
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::cli(
  $ensure         = $php::cli::params::ensure,
  $package        = $php::cli::params::package,
  $provider       = $php::cli::params::provider,
  $config_file    = $php::cli::params::config_file,
  $config_changes = $php::cli::params::config_changes
) inherits php::cli::params {

  php::contrib::base_package { 'cli':
  	ensure  => $ensure,
  	provider => $provider;
  }

  package { $package:
    ensure	 => $ensure,
    provider => $provider;
  }

  php::config { 'php-cli':
    config_file     => $config_file,
    config_changes  => $config_changes
  }

}
