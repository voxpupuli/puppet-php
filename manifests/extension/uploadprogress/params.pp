# == Class: php::extension::uploadprogress::params
#
# Defaults file for the uploadprogress PHP extension
#
# === Parameters
#
# No parameters
#
# === Variables
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
# === Examples
#
# No examples
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
#
class php::extension::uploadprogress::params {

  $ensure   = $php::params::ensure
  $package  = 'uploadprogress'
  $provider = 'pecl'
  $inifile  = '/etc/php5/conf.d/uploadprogress.ini'
  $settings = {
    set => {
      '.anon/extension' => 'uploadprogress.so'
    }
  }

}
