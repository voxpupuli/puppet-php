# Configure ubuntu ppa
#
# === Parameters
#
# [*version*]
#   PHP version to manage (e.g. 5.6)
#
class php::repo::ubuntu (
  Pattern[/^\d\.\d/] $version = '5.6',
) {
  if $facts['os']['name'] != 'Ubuntu' {
    fail("class php::repo::ubuntu does not work on OS ${facts['os']['name']}")
  }
  include 'apt'

  if ($version == '5.5') {
    fail('PHP 5.5 is no longer available for download')
  }

  $version_repo = $version ? {
    '5.4'   => 'ondrej/php5-oldstable',
    default => 'ondrej/php'
  }

  ::apt::ppa { "ppa:${version_repo}":
    package_manage => true,
  }
}
