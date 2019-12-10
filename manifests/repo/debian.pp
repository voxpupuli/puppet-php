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
class php::repo::debian(
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

  $php_version = $php::globals::php_version

  if ($sury and $php_version != undef and
      (
        $php_version == '5.6'
        or versioncmp($php_version, '7.1') >= 0
      )) {
    apt::source { 'source_php_sury':
      location => 'https://packages.sury.org/php/',
      repos    => 'main',
      include  => {
        'src' => $include_src,
        'deb' => true,
      },
      key      => {
        id     => '15058500A0235D97F5D10063B188E2B695BD4743',
        source => 'https://packages.sury.org/php/apt.gpg',
      },
    }
  }
}
