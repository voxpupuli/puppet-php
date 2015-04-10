# Configure package repository
#
class php::repo {

  anchor { 'php::repo': }

  $msg_no_repo = "No repo available for ${::osfamily}/${::operatingsystem}"

  case $::osfamily {
    'Debian': {
      # no anchors here because apt does that already
      case $::operatingsystem {
        'Debian': {
          include ::php::repo::debian
        }
        'Ubuntu': {
          include ::php::repo::ubuntu
        }
        default: {
          fail($msg_no_repo)
        }
      }
    }
    'Suse': {
      include ::php::repo::suse

      Class['::php::repo::suse'] ->
      Anchor['php::repo']
    }
    'RedHat': {
      include '::php::repo::redhat'

      Class['::php::repo::redhat'] ->
      Anchor['php::repo']
    }
    default: {
      fail($msg_no_repo)
    }
  }
}
