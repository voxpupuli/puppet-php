# == Class: php::repo::ubuntu
#
# Configure ubuntu ppa
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
  include '::apt'

  apt::ppa { 'ppa:ondrej/php5': }
}
