# Configure a yum repo for RedHat-based systems
#
# === Parameters
#
# [*yum_repo*]
#   Class name of the repo under ::yum::repo
#

class php::repo::redhat (
  String[1] $version = '5.6',
) {
  $releasever = $facts['os']['name'] ? {
    /(?i:Amazon)/ => '6',
    default       => '$releasever',  # Yum var
  }
  $no_dot_version = $version.delete('.')

  yumrepo { 'remi':
    descr      => 'Remi\'s RPM repository for Enterprise Linux $releasever - $basearch',
    mirrorlist => "https://rpms.remirepo.net/enterprise/${releasever}/remi/mirror",
    enabled    => 1,
    gpgcheck   => 1,
    gpgkey     => 'https://rpms.remirepo.net/RPM-GPG-KEY-remi',
    priority   => 1,
  }

  yumrepo { "remi-php${no_dot_version}":
    descr      => "Remi's PHP ${version} RPM repository for Enterprise Linux \$releasever - \$basearch",
    mirrorlist => "https://rpms.remirepo.net/enterprise/${releasever}/php${no_dot_version}/mirror",
    enabled    => 1,
    gpgcheck   => 1,
    gpgkey     => 'https://rpms.remirepo.net/RPM-GPG-KEY-remi',
    priority   => 1,
  }
}
