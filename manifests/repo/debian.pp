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
# [*sury*]
#   Enable special sury handling
#
class php::repo::debian (
  $location     = 'https://packages.dotdeb.org',
  $release      = 'wheezy-php56',
  $repos        = 'all',
  $include_src  = false,
  $key          = {
    'id'     => '6572BBEF1B5FF28B28B706837E3F070089DF5277',
    'source' => 'http://www.dotdeb.org/dotdeb.gpg',
  },
  $dotdeb       = true,
  $sury         = true,
) {
  assert_private()

  include 'apt'

  apt::source { "source_php_${release}":
    location => $location,
    release  => $release,
    repos    => $repos,
    include  => {
      'src' => $include_src,
      'deb' => true,
    },
    key      => $key,
  }

  if ($dotdeb) {
    # both repositories are required to work correctly
    # See: http://www.dotdeb.org/instructions/
    if $release == 'wheezy-php56' {
      apt::source { 'dotdeb-wheezy':
        location => $location,
        release  => 'wheezy',
        repos    => $repos,
        include  => {
          'src' => $include_src,
          'deb' => true,
        },
      }
    }
  }

  if ($sury and $php::globals::php_version in ['5.6','7.1','7.2']) {
    apt::source { 'source_php_sury':
      location => 'https://packages.sury.org/php/',
      repos    => 'main',
      include  => {
        'src' => $include_src,
        'deb' => true,
      },
      key      => {
        id     => 'DF3D585DB8F0EB658690A554AC0E47584A7A714D',
        source => 'https://packages.sury.org/php/apt.gpg',
      },
    }
  }
}
