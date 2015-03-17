# Base class with global configuration parameters that pulls in all
# enabled components.
#
# === Parameters
#
# [*ensure*]
#   Specify which version of PHP packages to install, defaults to 'latest'.
#   Please note that 'absent' to remove packages is not supported!
#
# [*manage_repos*]
#   Include repository (dotdeb, ppa, etc.) to install recent PHP from
#
# [*fpm*]
#   Install and configure php-fpm
#
# [*dev*]
#   Install php header files, needed to install pecl modules
#
# [*composer*]
#   Install and auto-update composer
#
# [*pear*]
#   Install PEAR
#
# [*phpunit*]
#   Install phpunit
#
# [*extensions*]
#   Install PHP extensions, this is overwritten by hiera hash `php::extensions`
#
# [*package_prefix*]
#   This is the prefix for constructing names of php packages. This defaults
#   to a sensible default depending on your operating system, like 'php-' or
#   'php5-'.
#
class php (
  $ensure         = $php::params::ensure,
  $manage_repos   = $php::params::manage_repos,
  $fpm            = true,
  $dev            = true,
  $composer       = true,
  $pear           = true,
  $pear_ensure    = $php::params::pear_ensure,
  $phpunit        = false,
  $extensions     = {},
  $settings       = {},
  $package_prefix = $php::params::package_prefix,
) inherits php::params {

  validate_string($ensure)
  validate_bool($manage_repos)
  validate_bool($fpm)
  validate_bool($dev)
  validate_bool($composer)
  validate_bool($pear)
  validate_string($pear_ensure)
  validate_bool($phpunit)
  validate_hash($extensions)
  validate_hash($settings)

  if $manage_repos {
    class { '::php::repo': } ->
    Anchor['php::begin']
  }

  anchor { 'php::begin': } ->
    class { '::php::packages': } ->
    class { '::php::cli':
      settings => $settings,
    } ->
  anchor { 'php::end': }

  if $fpm {
    Anchor['php::begin'] ->
      class { '::php::fpm':
        settings => $settings,
      } ->
    Anchor['php::end']
  }
  if $dev {
    Anchor['php::begin'] ->
      class { '::php::dev': } ->
    Anchor['php::end']
  }
  if $composer {
    Anchor['php::begin'] ->
      class { '::php::composer': } ->
    Anchor['php::end']
  }
  if $pear {
    Anchor['php::begin'] ->
      class { '::php::pear':
        ensure => $pear_ensure,
      } ->
    Anchor['php::end']
  }
  if $phpunit {
    Anchor['php::begin'] ->
      class { '::php::phpunit': } ->
    Anchor['php::end']
  }

  # FIXME: for deep merging support we need a explicit hash lookup instead of
  #        automatic parameter lookup
  #        (https://tickets.puppetlabs.com/browse/HI-118)
  $real_settings = hiera_hash('php::settings', $settings)

  $real_extensions = hiera_hash('php::extensions', $extensions)
  create_resources('php::extension', $real_extensions, {
    ensure  => $ensure,
    require => Class['php::cli'],
    before  => Anchor['php::end']
  })

  # On FreeBSD purge the system-wide extensions.ini. It is going
  # to be replaced with per-module configuration files.
  if $::osfamily == 'FreeBSD' {
    # Purge the system-wide extensions.ini
    file { '/usr/local/etc/php/extensions.ini':
      ensure  => absent,
      require => Class['php::packages'],
    }
  }
}
