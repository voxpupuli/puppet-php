# == Class: php::cli::params
#
# Defaults file for CLI package
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*ensure*]
#   The ensure of the CLI package to install
#   Could be "latest", "installed" or a pinned verison
#
# [*package*]
#   The package name for CLI package
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
# === Examples
#
#  include 'php::cli::package'
#
#  class {'php::cli::package
#   ensure => latest
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
class php::cli::params {

  $ensure        = $php::params::ensure
  $package        = 'php5-cli'
  $provider       = undef
  $config_file    = '/etc/php5/cli/php.ini'
  $config_changes = {
    set => {
      'PHP/short_open_tag'       => 'Off',
      'PHP/asp_tags'             => 'Off',
      'PHP/expose_php'           => 'Off',
      'PHP/memory_limit'         => '1G',
      'PHP/display_errors'       => 'Off',
      'PHP/log_errors'           => 'On',
      'PHP/post_max_size'        => '500M',
      'PHP/upload_max_filesize'  => '500M',
      'PHP/max_execution_time'   => 600,
      'PHP/allow_url_include'    => 'Off',
      'PHP/error_log'            => 'syslog',
      'PHP/output_buffering'     => 4096,
      'PHP/output_handler'       => 'Off',
      'Date/date.timezone'       => 'UTC'
    }
  }

}
