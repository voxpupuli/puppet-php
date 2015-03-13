# Configure ubuntu ppa
#
class php::repo::ubuntu {
  include '::apt'

  apt::ppa { 'ppa:ondrej/php5': }
}
