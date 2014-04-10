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

  $ensure = 'installed'

  $config_root = '/etc/php5'

  $config_root_ini = "${::php::params::config_root}/mods-available"

  $augeas_contrib_dir = '/usr/share/augeas/lenses/contrib'

  case $::osfamily {
    'Suse': {
      $base_package = false
    }
    default: {
      $base_package = true
    }
  }
}
