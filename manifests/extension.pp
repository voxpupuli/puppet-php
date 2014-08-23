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
#   system packages dependecies to install for pecl extensions (e.g. for memcached libmemcached-dev on debian)
#
# [*config*]
#   Nested hash of key => value to apply to php.ini
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
  $pecl_source     = undef,
  $package_prefix  = $php::params::package_prefix,
  $header_packages = [],
  $config          = {},
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
      source   => $pecl_source,
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
    'pecl'  => merge({'extension' => "'${name}.so'"}, $config),
    default => $config
  }
  $php_config_file = "${php::params::config_root_ini}/${lowercase_title}.ini"

  php::config { $title:
    file   => $php_config_file,
    config => $real_config
  }

  # FIXME: On Ubuntu/Debian systems we use the mods-available folder and have
  # to enable config files ourselves
  if $::osfamily == 'Debian' {
    $symlinks = ["${php::params::config_root}/cli/conf.d/20-${lowercase_title}.ini"]
    $real_symlinks = concat($symlinks, $php::fpm ? {
      true    => ["${php::params::config_root}/fpm/conf.d/20-${lowercase_title}.ini"],
      default => [],
    })

    file { $real_symlinks:
      ensure  => link,
      target  => $php_config_file,
      require => Php::Config[$title],
    }
  }
}
