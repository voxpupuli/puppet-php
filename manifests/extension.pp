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
# [*package*]
#   Package name as defined in the package provider
#   PECL: there currently is a hack to allow prepending `pecl-` to avoid duplicate package declarations
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
  $package         = undef,
  $header_packages = [],
  $config          = [],
) {

  if $caller_module_name != $module_name {
    warning("${name} is not part of the public API of the ${module_name} module and should not be directly included in the manifest.")
  }

  validate_string($ensure)

  if $package {
    $real_package = $package
  } elsif $provider == 'pecl' {
    $real_package = $title
  } else {
    $real_package = "php5-${title}"
  }

  if $provider == 'pecl' {
    include php::pear
    include php::dev

    package { $real_package:
      ensure   => $ensure,
      provider => $provider,
      require  => [
        Class['php::pear'],
        Class['php::dev'],
      ]
    }
  } else {
    package { $real_package:
      ensure   => $ensure,
      provider => $provider;
    }
  }

  ensure_resource('package', $header_packages, {
    before => Package[$real_package]
  })

  $title_without_prefix = regsubst($title, 'pecl-', '')
  $lowercase_title = downcase($title)
  $real_config = $provider ? {
    'pecl'  => concat(["set .anon/extension '${title_without_prefix}.so'"], $config),
    default => $config
  }
  php::config { $title:
    file   => "${php::params::config_root_ini}/${lowercase_title}.ini",
    config => $real_config
  }
}
