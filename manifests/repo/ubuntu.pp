# == Class: php::repo::ubuntu
#
# Configure ubuntu ppa
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
#  include php::apt
#
# === Authors
#
# Robin Gloster <robin.gloster@mayflower.de>
#
# === Copyright
#
# See LICENSE file
#
class php::repo::ubuntu {
  apt::ppa { 'ppa:ondrej/php5': }
}
