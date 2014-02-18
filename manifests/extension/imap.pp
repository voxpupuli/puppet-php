# == Class: php::extension::imap
#
# Install and configure the imap PHP extension
#
# === Parameters
#
# [*ensure*]
#   The version of the package to install
#   Could be "latest", "installed" or a pinned version
#   This matches "ensure" from Package
#
# [*package*]
#   The package name in your provider
#
# [*provider*]
#   The provider used to install the package
#
# [*inifile*]
#   The path to the extension ini file
#
# [*settings*]
#   Hash with 'set' nested hash of key => value
#   set changes to agues when applied to *inifile*
#
# === Variables
#
# No variables
#
# === Examples
#
#  include php::extension::imap
#
# === Authors
#
# Arthur Andersen <leoc.git@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::extension::imap(
  $ensure   = $php::extension::imap::params::ensure,
  $package  = $php::extension::imap::params::package,
  $provider = $php::extension::imap::params::provider,
  $inifile  = $php::extension::imap::params::inifile,
  $settings = $php::extension::imap::params::settings,
) inherits php::extension::imap::params {

  php::extension { 'imap':
    ensure   => $ensure,
    package  => $package,
    provider => $provider
  }

  php::config { 'php-extension-imap':
    inifile   => $inifile,
    settings  => $settings
  }
}
