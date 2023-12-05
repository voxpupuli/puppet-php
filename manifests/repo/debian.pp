# Configure debian apt repo
#
# === Parameters
#
# [*location*]
#   Location of the apt repository
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
  String[1] $repos        = 'all',
  Boolean $include_src    = false,
  Hash $key               = {
    'id'     => '6572BBEF1B5FF28B28B706837E3F070089DF5277',
    'source' => 'http://www.dotdeb.org/dotdeb.gpg',
  },
  Boolean $dotdeb         = true,
  Boolean $sury           = true,
) {
  assert_private()

  if $facts['os']['name'] != 'Debian' {
    fail("class php::repo::debian does not work on OS ${facts['os']['name']}")
  }
  include 'apt'

  if ($dotdeb and versioncmp($facts['os']['release']['major'], '9') < 1) {
    apt::source { 'source_php_dotdeb':
      location => $location,
      repos    => $repos,
      include  => {
        'src' => $include_src,
        'deb' => true,
      },
      key      => $key,
    }
  }

  if ($sury and versioncmp($facts['os']['release']['major'], '9') >= 0) {
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
