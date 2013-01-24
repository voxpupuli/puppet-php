# == Class: php::pecl::package
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
# php::pecl::package { "apc": }
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
define php::pecl::package {
  include php::params

  $mod = $name
  $extensions = $php::params::extensions
  $extension = $extensions[$mod]

  $package_name = $extension['package']
  $provider_name = $extension['provider']

  if $provider_name == 'pecl' {
    package { $package_name:
      ensure   => $php::params::php_version,
      provider => $provider_name,
      pipe     => $extension['pipe'];
    }
  } else {
    package { $package_name:
      ensure   => $php::params::php_version,
      provider => $provider_name;
    }
  }

  if $extension['require'] {
    $extension['require'] -> Package[$package_name]
  }

  if $extension['notify'] {
    Package[$package_name] ~> $extension['notify']
  }
}
