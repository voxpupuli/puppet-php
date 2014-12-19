# == Class: php::repo
#
# Configure package repository
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

  anchor { 'php::repo': }

  $msg_no_repo = "No repo available for ${::osfamily}/${::operatingsystem}"

  case $::osfamily {
    'Debian': {
      # no anchors here because apt does that already
      case $::operatingsystem {
        'Debian': {
          include php::repo::debian
        }
        'Ubuntu': {
          include php::repo::ubuntu
        }
        default: {
          fail($msg_no_repo)
        }
      }
    }
    'Suse': {
      include php::repo::suse

      Class['php::repo::suse'] ->
      Anchor['php::repo']
    }
    'RedHat': {
      include '::yum::repo::epel'

      Class['::yum::repo::epel'] ->
      Anchor['php::repo']
    }
    default: {
      fail($msg_no_repo)
    }
  }
}
