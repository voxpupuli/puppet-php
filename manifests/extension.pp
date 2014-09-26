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
# [*pecl_source*]
#   The pecl source channel to install pecl package from
#
# [*header_packages*]
#   system packages dependecies to install for extensions (e.g. for memcached libmemcached-dev on debian)
#
# [*settings*]
#   Nested hash of global config parameters for php.ini
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
# Robin Gloster <robin.gloster@mayflower.de>
# Franz Pletz <franz.pletz@mayflower.de>
#
# === Copyright
#
# See LICENSE file
#
define php::extension(
  $ensure            = 'installed',
  $provider          = undef,
  $pecl_source       = undef,
  $package_prefix    = $php::params::package_prefix,
  $header_packages   = [],
  $compiler_packages = $php::params::compiler_packages,
  $settings            = {},
) {

  if $caller_module_name != $module_name {
    warning("${name} is not part of the public API of the ${module_name} module and should not be directly included in the manifest.")
  }

  validate_string($ensure)
  validate_string($package_prefix)
  validate_array($header_packages)

  if $provider == 'pecl' {
      $real_package = "pecl-${title}"
  } else {
      $real_package = "${package_prefix}${title}"
  }

  ensure_resource('package', $header_packages, {
    before => Package[$real_package]
  })

  if $provider == 'pecl' {
    package { $real_package:
      ensure   => $ensure,
      provider => $provider,
      source   => $pecl_source,
      require  => [
        Class['php::pear'],
        Class['php::dev'],
      ]
    }

    ensure_resource('package', $compiler_packages, {
      before => Package[$real_package]
    })
  } else {
    package { $real_package:
      ensure   => $ensure,
      provider => $provider;
    }
  }

  $lowercase_title = downcase($title)
  $real_settings = $provider ? {
    'pecl'  => deep_merge({'extension' => "${name}.so"}, $settings),
    default => $settings
  }
  $php_settings_file = "${php::params::config_root_ini}/${lowercase_title}.ini"

  php::config { $title:
    file   => $php_settings_file,
    config => $real_settings
  }

  # FIXME: On Ubuntu/Debian systems we use the mods-available folder and have
  # to enable settings files ourselves
  if $::osfamily == 'Debian' and versioncmp($::php_version, '5.4') >= 0 {
    $symlinks = ["${php::params::config_root}/cli/conf.d/20-${lowercase_title}.ini"]
    $real_symlinks = concat($symlinks, $php::fpm ? {
      true    => ["${php::params::config_root}/fpm/conf.d/20-${lowercase_title}.ini"],
      default => [],
    })

    file { $real_symlinks:
      ensure  => link,
      target  => $php_settings_file,
      require => Php::Config[$title],
    }
  }
}
