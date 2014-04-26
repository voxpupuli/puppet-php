# == Class: php::params
#
# PHP params class
#
# Configuration class for php module
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*ensure*]
#   The PHP ensure of PHP to install
#
# === Examples
#
#  include php::dev
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
class php::params {

  $config_root        = '/etc/php5'
  $augeas_contrib_dir = '/usr/share/augeas/lenses/contrib'
  $fpm_package        = 'php5-fpm'
  $fpm_inifile        = '/etc/php5/fpm/php.ini'

  case $::osfamily {
    'Suse': {
      $base_package     = false
      $config_root_ini  = "${config_root}/conf.d"
      $fpm_service_name = 'php-fpm'
      $fpm_user         = 'nginx'
      $dev_package  = 'php5-devel'
    }
    'Debian': {
      $base_package     = true
      $config_root_ini  = "${config_root}/mods-available"
      $fpm_service_name = 'php5-fpm'
      $fpm_user         = 'www-data'
      $dev_package  = 'php5-dev'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} only support osfamily Debian, and Suse")
    }
  }
}
