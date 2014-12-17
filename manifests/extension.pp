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
#   If set to "none", no package will be installed
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

  if $provider != 'none' {
    if $provider == 'pecl' {
      $real_package = "pecl-${title}"
    }
    else {
      $real_package = "${package_prefix}${title}"
    }

    ensure_resource('package', $header_packages)
    Package[$header_packages] -> Package[$real_package]

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

      ensure_resource('package', $compiler_packages)
      Package[$compiler_packages] -> Package[$real_package]
    }
    else {
      package { $real_package:
        ensure   => $ensure,
        provider => $provider;
      }
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
    config => $real_settings,
  }

  # Ubuntu/Debian systems use the mods-available folder. We need to enable
  # settings files ourselves with php5enmod command.
  if $::osfamily == 'Debian' and $::php_version == '' or versioncmp($::php_version, '5.4') >= 0 {
    $cmd = "php5enmod ${lowercase_title}"

    exec { $cmd:
      refreshonly => true,
    }

    Php::Config[$title] ~> Exec[$cmd]

    Package <| name == $php::fpm::package |> ~> Exec[$cmd]
  }
}
