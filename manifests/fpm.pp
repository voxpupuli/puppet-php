# == Class: php::fpm
#
# Install and configure mod_php for fpm
#
# === Parameters
#
# [*ensure*]
#   The ensure of the fpm package to install
#   Could be "latest", "installed" or a pinned verison
#
# [*package*]
#   The package name for fpm package
#   For debian it's php5-fpm
#
# [*provider*]
#   The provider used to install php5-fpm
#   Could be "pecl", "apt" or any other OS package provider
#
# [*inifile*]
#   The path to the ini php5-fpm ini file
#
# [*settings*]
#   Hash with 'set' nested hash of key => value
#   set changes to agues when applied to *inifile*
#
# === Variables
#
# No variables
#
# === Examples
#
#  include php::fpm
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
class php::fpm(
  $ensure   = $php::fpm::params::ensure,
  $package  = $php::fpm::params::package,
  $provider = $php::fpm::params::provider,
  $inifile  = $php::fpm::params::inifile,
  $settings = $php::fpm::params::settings
) inherits php::fpm::params {

  package { $package:
    ensure   => $ensure,
    provider => $provider;
  }

  php::config { 'php-fpm':
    inifile  => $inifile,
    settings => $settings
  }

  service { 'php5-fpm':
    ensure    => running,
    enable    => true,
    restart   => 'service php5-fpm reload',
    hasstatus => true,
    require   => Package[$package]
  }

}
