# == Class: php::extension
#
# Install a PHP extension package
#
# === Parameters
#
# [*ensure*]
#   The ensure of the package to install
#   Could be "latest", "installed" or a pinned version
#
# [*package_prefix*]
#   Prefix to prepend to the package name for the package provider
#
# [*provider*]
#   The provider used to install the package
#   Could be "pecl", "apt", "dpkg" or any other OS package provider
#
# [*header_packages*]
#   system packages dependecies to install for pecl extensions (e.g. for memcached libmemcached-dev on debian)
#
# [*config*]
#   augeas commands to configure the extension
#
# === Variables
#
# === Examples
#
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
# Robin Gloster <robin.gloster@mayflower.de>
#
# === Copyright
#
# See LICENSE file
#
define php::extension(
  $ensure          = 'installed',
  $provider        = undef,
  $package_prefix  = $php::params::package_prefix,
  $header_packages = [],
  $config          = [],
) {

  if $caller_module_name != $module_name {
    warning("${name} is not part of the public API of the ${module_name} module and should not be directly included in the manifest.")
  }

  validate_string($ensure)
  validate_string($package_prefix)
  validate_array($header_packages)

  if $provider == 'pecl' {
    $pecl_package = "pecl-${title}"

    package { $pecl_package:
      ensure   => $ensure,
      provider => $provider,
      require  => [
        Class['php::pear'],
        Class['php::dev'],
      ]
    }

    ensure_resource('package', $header_packages, {
      before => Package[$pecl_package]
    })
  } else {
    package { "${package_prefix}${title}":
      ensure   => $ensure,
      provider => $provider;
    }
  }

  $lowercase_title = downcase($title)
  $real_config = $provider ? {
    'pecl'  => concat(["set .anon/extension '${title}.so'"], $config),
    default => $config
  }
  php::config { $title:
    file   => "${php::params::config_root_ini}/${lowercase_title}.ini",
    config => $real_config
  }
}
