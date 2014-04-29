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
#
# [*provider*]
#   The provider used to install the package
#   Could be "pecl", "apt", "dpkg" or any other OS package provider
#
# [*pipe*]
#   Used to answer interactive questions from pecl
#   Some extensions require answers on different questions. To provide answers
#   supply a list of lines with answers - one answer per line
#
# [*source*]
#   The path to the deb package to install
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
# $answers = "shared
# /usr
# all"
# php::extension { 'libenchant':
#   ensure   => "latest",
#   package  => "enchant",
#   provider => "pecl",
#   pipe     => $answers;
# }
#
# php::extension { 'gearman':
#   ensure   => "latest",
#   package  => "libgearman8",
#   provider => "dpkg",
#   source   => "/path/to/libgearman8_1.1.7-1_amd64.deb";
# }
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
  $ensure   = 'installed',
  $provider = undef,
  $package  = undef,
  $config   = []
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
