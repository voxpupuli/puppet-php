# == Class: php
#
# PHP base class
#
# === Parameters
#
# No parameters
#
# === Variables
#
# No variables
#
# === Examples
#
#  include php
#
# === Authors
#
# Robin Gloster <robin.gloster@mayflower.de>
#
# === Copyright
#
# See LICENSE file
#
class php (
  $manage_repos = true,
  $fpm          = true,
  $apache       = false,
  $dev          = true,
  $composer     = true,
  $pear         = true,
  $extensions   = {}
) {
  validate_bool($manage_repos)
  validate_bool($fpm)
  validate_bool($apache)
  validate_bool($dev)
  validate_bool($composer)
  validate_bool($pear)
  validate_hash($extensions)

  if $manage_repos {
    anchor{ 'php::repo': } ->
      class { 'php::repo': } ->
    Anchor['php::begin']
  }

  anchor { 'php::begin': } ->
    class { 'php::cli': }
  anchor { 'php::end': }

  if $fpm {
    Anchor['php::begin'] ->
      class { 'php::fpm': } ->
    Anchor['php::end']
  }
  if $apache {
    Anchor['php::begin'] ->
      class { 'php::apache': } ->
    Anchor['php::end']
  }
  if $dev {
    Anchor['php::begin'] ->
      class { 'php::dev': } ->
    Anchor['php::end']
  }
  if $composer {
    Anchor['php::begin'] ->
      class { 'php::composer': } ->
    Anchor['php::end']
  }
  if $pear {
    Anchor['php::begin'] ->
      class { 'php::pear': } ->
    Anchor['php::end']
  }

  # FIXME: for deep merging support we need a explicit hash lookup instead of automatic parameter lookup
  #        (https://tickets.puppetlabs.com/browse/HI-118)
  $real_extensions = hiera_hash('php::extensions', $extensions)
  create_resources('php::extension', $real_extensions, {
    ensure  => latest,
    require => Anchor['php::begin'],
    before  => Anchor['php::end']
  })
  Class['php::pear'] -> Php::Extension <| provider == pecl |>
}
