# == Class: php::contrib::base_package
#
# Install php base package.
#
# === Parameters
#
# [*ensure*]
#   The ensure value
#
# [*provider*]
#   The provider
#
# === Variables
#
# No variables
#
# === Examples
#
#
#
# === Authors
#
#
#
# === Copyright
#
#
#
define php::contrib::base_package($ensure, $provider) {

  if !defined(Package['php5-common']) {
    package { 'php5-common':
      ensure   => $ensure,
      provider => $provider
    }
  }

}
