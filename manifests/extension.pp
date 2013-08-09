# == Class: php::extension
#
# Install a PHP extension package
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*php_ensure*]
#   The ensure of APC to install
#
# === Examples
#
# php::extension { "apc": }
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
define php::extension(
  $ensure,
  $package,
  $provider,
  $pipe = undef
) {

  if $provider == 'pecl' {
    package { $package:
      ensure   => $ensure,
      provider => $provider,
      pipe     => $pipe;
    }
  } else {
    package { $package:
      ensure   => $ensure,
      provider => $provider;
    }
  }

}
