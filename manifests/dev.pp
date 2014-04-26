# == Class: php::dev
#
# PHP dev package
#
# Install the development headers for PHP
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*ensure*]
#   The PHP ensure of PHP dev to install
#
# [*package*]
#   The package name for PHP dev
#   For debian it's php5-dev
#
# [*provider*]
#   The provider used to install php5-dev
#   Could be "pecl", "apt" or any other OS package provider
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
class php::dev(
  $ensure   = present,
  $package  = $php::params::dev_package,
) inherits php::params {

  if $php::params::base_package {
    php::contrib::base_package { 'dev':
      ensure   => $ensure,
    }
  }

  package { $package:
    ensure   => $ensure,
  }
}
