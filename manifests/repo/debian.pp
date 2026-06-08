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
    'name'   => 'dotdeb.asc',
    'source' => 'https://www.dotdeb.org/dotdeb.gpg',
  },
  Boolean $dotdeb         = true,
  Boolean $sury           = true,
  String[1] $key_source   = 'https://packages.sury.org/php/apt.gpg',
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
    apt::keyring { 'packages-sury-org.gpg':
      source => $key_source,
    }

    apt::source { 'source_php_sury':
      location => 'https://packages.sury.org/php/',
      repos    => 'main',
      include  => {
        'src' => $include_src,
        'deb' => true,
      },
      keyring  => '/etc/apt/keyrings/packages-sury-org.gpg',
      require  => Apt::Keyring['packages-sury-org.gpg'],
    }
  }
}
