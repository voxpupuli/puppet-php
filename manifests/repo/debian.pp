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
  String[1] $location     = 'https://packages.dotdeb.org',
  String[1] $release      = 'wheezy-php56',
  String[1] $repos        = 'all',
  Boolean $include_src    = false,
  Hash $key               = {
    'id'     => '6572BBEF1B5FF28B28B706837E3F070089DF5277',
    'source' => 'http://www.dotdeb.org/dotdeb.gpg',
  },
  Boolean $dotdeb         = true,
  Boolean $sury           = true,
) {
  include 'apt'

  if ($dotdeb) {
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
  }

  if ($sury) {
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
