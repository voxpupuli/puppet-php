# Configure debian apt repo
#
# === Parameters
#
# [*location*]
#   Location of the apt repository
#
# [*release*]
#   Release of the apt repository
#
# [*repos*]
#   Apt repository names
#
# [*include_src*]
#   Add source source repository
#
# [*key*]
#   Public key in apt::key format
#
# [*dotdeb*]
#   Enable special dotdeb handling
#
class php::repo::debian(
  $location     = 'http://packages.dotdeb.org',
  $version      = '5.6',
  $repos        = 'all',
  $include_src  = false,
  $key          = {
    'id'     => '6572BBEF1B5FF28B28B706837E3F070089DF5277',
    'source' => 'http://www.dotdeb.org/dotdeb.gpg',
  },
  $dotdeb       = true,
) {

  if $caller_module_name != $module_name {
    warning('php::repo::debian is private')
  }

  if $::php::params::php_version {
    $php_version = $::php::params::php_version
  } else {
    $php_version = $version
  }

  include '::apt'

  create_resources(::apt::key, { 'php::repo::debian' => {
    id     => $key['id'],
    source => $key['source'],
  }})

  case $::lsbdistcodename {
    'wheezy': {
      case $php_version {
        /^7\.[0-9]$/: {
          fail("PHP version ${php_version} is not supported on ${::operatingsystem} (${::lsbdistcodename})")
        }
        default, '5.4': {} # 5.4 is the default bundled PHP in Wheezy
        '5.5': {
          ::apt::source { "source_php_${::lsbdistcodename}-php55":
            location    => $location,
            release     => "${::lsbdistcodename}-php55",
            repos       => $repos,
            include_src => $include_src,
            require     => Apt::Key['php::repo::debian'],
          }
        }
        '5.6': {
          ::apt::source { "source_php_${::lsbdistcodename}-php56":
            location    => $location,
            release     => "${::lsbdistcodename}-php56",
            repos       => $repos,
            include_src => $include_src,
            require     => Apt::Key['php::repo::debian'],
          }
        }
      }
    }
    default: {
      case $php_version {
        /^7\.[0-9]$/: {
          ::apt::source { "source_php_${::lsbdistcodename}":
            location    => $location,
            release     => $::lsbdistcodename,
            repos       => $repos,
            include_src => $include_src,
            require     => Apt::Key['php::repo::debian'],
          }
        }
        default, '5.6': {} # 5.6 is the default bundled PHP in Jessie
      }
    }
  }
}
