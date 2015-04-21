# Configure ubuntu ppa
#
# === Parameters
#
# [*oldstable*]
#   Install 5.4 (ondrej/php5-oldstable PPA)
#
class php::repo::ubuntu (
  $oldstable = false,
) {
  include '::apt'

  validate_bool($oldstable)

  if ($::lsbdistcodename == 'precise' or $oldstable == true) {
    ::apt::ppa { 'ppa:ondrej/php5-oldstable': }
  } else {
    ::apt::ppa { 'ppa:ondrej/php5': }
  }
}
