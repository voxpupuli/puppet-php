# == Class: php::repo
#
# Configure package repository
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
#  TODO
#
# === Authors
#
# Robin Gloster <robin.gloster@mayflower.de>
#
# === Copyright
#
# See LICENSE file
#
class php::repo {

  anchor { 'php::repo::begin': } ->
  anchor { 'php::repo::end': }

  case $::osfamily {
    'Debian': {
      case $::operatingsystem {
        'Debian': {
          # code
        }
        'Ubuntu': {
          # code
        }
        default: {
          fail("No repo available for ${::osfamily}/${::operatingsystem}, please fork this module and add one in repo.pp")
        }
      }
    }
    'Suse': {
      include php::repo::suse

      Anchor['php::repo::begin'] ->
        Class['php::repo::suse'] ->
      Anchor['php::repo::end']
    }
    default: {
      fail("No repo available for ${::osfamily}/${::operatingsystem}, please fork this module and add one in repo.pp")
    }
  }
}
