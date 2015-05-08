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
# [*source*]
#   The source to install the extension from. Possible values
#   depend on the *provider* used
#
# [*pecl_source*]
#   The pecl source channel to install pecl package from
#   Superseded by *source*
#
# [*header_packages*]
#   System packages dependencies to install for extensions (e.g. for
#   memcached libmemcached-dev on debian)
#
# [*zend*]
#  Boolean parameter, whether to load extension as zend_extension.
#  This can only be set for pecl modules. Defaults to false.
#
# [*settings*]
#   Nested hash of global config parameters for php.ini
#
# [*settings_prefix*]
#   Boolean/String parameter, whether to prefix all setting keys with
#   the extension name or specified name. Defaults to false.
#
define php::extension(
  $ensure            = 'installed',
  $provider          = undef,
  $source            = undef,
  $pecl_source       = undef,
  $package_prefix    = $::php::package_prefix,
  $header_packages   = [],
  $compiler_packages = $::php::params::compiler_packages,
  $zend              = false,
  $settings          = {},
  $settings_prefix   = false,
) {

  if $caller_module_name != $module_name {
    warning('php::extension is private')
  }

  validate_string($ensure)
  validate_string($package_prefix)
  validate_array($header_packages)
  validate_bool($zend)

  if $source and $pecl_source {
    fail('Only one of $source and $pecl_source can be specified.')
  }

  if $source {
    $real_source = $source
  }
  else {
    $real_source = $pecl_source
  }

  if $provider != 'none' {
    if $provider == 'pecl' {
      $real_package = "pecl-${title}"
    }
    else {
      $real_package = "${package_prefix}${title}"
    }

    ensure_resource('package', $header_packages)
    Package[$header_packages] -> Package[$real_package] -> ::Php::Config[$title]

    if $provider == 'pecl' {
      package { $real_package:
        ensure   => $ensure,
        provider => $provider,
        source   => $real_source,
        require  => [
          Class['::php::pear'],
          Class['::php::dev'],
        ],
      }

      ensure_resource('package', $compiler_packages)
      Package[$compiler_packages] -> Package[$real_package]
    }
    else {
      package { $real_package:
        ensure   => $ensure,
        provider => $provider,
        source   => $real_source,
      }
    }
  }

  if $provider != 'pecl' and $zend {
    fail('You can only use the zend parameter for pecl PHP extensions!')
  }

  $extension_key = $zend ? {
    true  => 'zend_extension',
    false => 'extension',
  }

  $lowercase_title = downcase($title)

  # Ensure "<extension>." prefix is present in setting keys if requested
  if $settings_prefix {
    if is_string($settings_prefix) {
      $full_settings_prefix = $settings_prefix
    } else {
      $full_settings_prefix = $lowercase_title
    }
    $full_settings = ensure_prefix($settings, "${full_settings_prefix}.")
  } else {
    $full_settings = $settings
  }

  if $provider == 'pecl' {
    $final_settings = deep_merge(
      {"${extension_key}" => "${name}.so"},
      $full_settings
    )
  }
  else {
    # On FreeBSD systems the settings file is required for every module
    # (regardless of provider) to allow for proper module management.
    if $::osfamily == 'FreeBSD' {
      $final_settings = deep_merge(
        {"${extension_key}" => "${name}.so"},
        $full_settings
      )
    }
    else {
      $final_settings = $full_settings
    }
  }

  ::php::config { $title:
    file   => "${::php::params::config_root_ini}/${lowercase_title}.ini",
    config => $final_settings,
  }

  # Ubuntu/Debian systems use the mods-available folder. We need to enable
  # settings files ourselves with php5enmod command.
  if $::osfamily == 'Debian' {
    $cmd = "/usr/sbin/php5enmod ${lowercase_title}"

    exec { $cmd:
      refreshonly => true,
    }

    ::Php::Config[$title] ~> Exec[$cmd]

    if $::php::fpm {
      Package[$::php::fpm::package] ~> Exec[$cmd]
    }
  }
}
