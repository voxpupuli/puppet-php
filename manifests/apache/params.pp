# == Class: php::apache::params
#
# Defaults file for apache package
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*ensure*]
#   The version of the package to install
#   Could be "latest", "installed" or a pinned version
#   This matches "ensure" from Package
#
# [*package*]
#   The package name for apache package
#
# [*provider*]
#   The provider used to install package
#
# [*inifile*]
#   The path to the ini php5 apache ini file
#
# [*settings*]
#   Hash with 'set' nested hash of key => value
#   set changes to agues when applied to *inifile*
#
# === Examples
#
# No examples
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
class php::apache::params {

  $ensure   = $php::params::ensure
  $package  = 'libapache2-mod-php5'
  $provider = undef
  $inifile  = '/etc/php5/apache2/php.ini'
  $settings = {
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
