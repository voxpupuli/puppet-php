# Configure ubuntu apt repo (packages.sury.org)
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
#   Add source repository
#
# [*key_source*]
#   URL of the GPG key file
#
# [*version*]
#   Removed. PHP version selection via PPA is no longer supported.
#   All PHP versions are available from a single repository.
#
class php::repo::ubuntu (
  String[1] $location       = 'https://packages.sury.org/php/',
  String[1] $repos          = 'main',
  Boolean $include_src      = false,
  String[1] $key_source     = 'https://packages.sury.org/php/apt.gpg',
  Optional[String] $version = undef,
) {
  if $facts['os']['name'] != 'Ubuntu' {
    fail("class php::repo::ubuntu does not work on OS ${facts['os']['name']}")
  }

  if $version != undef {
    fail('php::repo::ubuntu: the $version parameter has been removed. packages.sury.org provides all PHP versions in a single repository.')
  }

  include 'apt'

  apt::keyring { 'packages-sury-org.gpg':
    source => $key_source,
  }

  apt::source { 'source_php_sury':
    location => $location,
    repos    => $repos,
    include  => {
      'src' => $include_src,
      'deb' => true,
    },
    keyring  => '/etc/apt/keyrings/packages-sury-org.gpg',
    require  => Apt::Keyring['packages-sury-org.gpg'],
  }
}
