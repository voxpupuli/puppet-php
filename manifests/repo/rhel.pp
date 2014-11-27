# == Class: php::repo::rhel
#
# Configure RHEL repo
#
# === Authors
#
# Vyacheslav Chudievich <gt.admin@rcstar.net>
#
# === Copyright
#
# See LICENSE file
#
class php::repo::rhel {
  include '::yum::repo::epel'
}
