# == Class: php::repo::suse
#
# Configure suse repo
#
# === Parameters
#
# [*reponame*]
#   Name of the Zypper repository
#
# [*baseurl*]
#   Base URL of the Zypper repository
#
# === Authors
#
# Robin Gloster <robin.gloster@mayflower.de>
#
# === Copyright
#
# See LICENSE file
#
class php::repo::suse (
  $reponame = 'mayflower-php55',
  $baseurl  = 'http://download.opensuse.org/repositories/home:/mayflower:/php5.5_based/SLE_11_SP3/',
) {
  zypprepo { $reponame:
    baseurl     => $baseurl,
    enabled     => 1,
    autorefresh => 1
  } ~>
  exec { 'zypprepo-accept-key':
    command     => 'zypper --gpg-auto-import-keys update -y',
    path        => '/usr/bin',
    refreshonly => true,
  }
}
