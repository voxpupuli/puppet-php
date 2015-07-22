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
  $oldstable = false,
  $ppa       = undef,
) {
  include '::apt'

  validate_bool($oldstable)

  if ($ppa and $oldstable == true) {
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
