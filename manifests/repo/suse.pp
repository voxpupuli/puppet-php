# == Class: php::repo::suse
#
# Configure suse repo
#
# === Parameters
#
# No parameters
#
# === Variables
#
# No variables
#
# === Examples
#
#  include php::apt
#
# === Authors
#
# Robin Gloster <robin.gloster@mayflower.de>
#
# === Copyright
#
# See LICENSE file
#
class php::repo::suse {
  zypprepo { 'mayflower-php54':
    baseurl => 'http://download.opensuse.org/repositories/home:/mayflower:/php5.4_based/SLE_11_SP3/',
  }
}
