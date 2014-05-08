# == Class: php
#
# PHP base class
#
# === Parameters
#
# [*manage_repos*]
#   Include repository (dotdeb, ppa, etc.) to install recent PHP from 
#
# [*fpm*]
#   Install and configure php-fpm
#
# [*apache*]
#   Install and configure apache php module, does not handle apache installation and configuration 
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
# [*extensions*]
#   Install PHP extensions, this is overwritten by hiera hash `php::extensions` 
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
}
