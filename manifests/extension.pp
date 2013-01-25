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
# [*php_version*]
#   The version of APC to install
#
# === Examples
#
# php::extension { "apc": }
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
define php::extension(
  $version,
  $package,
  $provider,
  $pipe = undef
) {

  if $provider == 'pecl' {
    package { $package:
      ensure   => $version,
      provider => $provider,
      pipe     => $pipe;
    }
  } else {
    package { $package:
      ensure   => $version,
      provider => $provider;
    }
  }

  if $require {
    $require -> Package[$package]
  }

  if $notify {
    Package[$package] ~> $notify
  }

}
