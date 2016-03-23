# Configure ubuntu ppa
#
# === Parameters
#
# [*oldstable*]
#   Install 5.4 (ondrej/php5-oldstable PPA)
#
# [*ppa*]
#   Use a specific PPA, e.g "ondrej/php5-5.6" (without the "ppa:")
#
class php::repo::ubuntu (
  $version   = '5.5',
  $ppa       = undef,
) {
  include '::apt'

  validate_re($version, '^\d\.\d')

  $version_repo = $version ? {
    '5.4' => 'ondrej/php5-oldstable'
    '5.5' => 'ondrej/php5'
    '5.6' => 'ondrej/php5-5.6'
    '7.0' => 'ondrej/php-7.0'
  }

  if ($ppa and $version == true) {
    fail('Only one of $oldstable and $ppa can be specified.')
  }

  if ($ppa) {
    ::apt::ppa { "ppa:${ppa}": }
  } elsif ($::lsbdistcodename == 'precise' or $oldstable == true) {
    ::apt::ppa { 'ppa:ondrej/php5-oldstable': }
  } else {
    ::apt::ppa { 'ppa:ondrej/php5': }
  }
}
