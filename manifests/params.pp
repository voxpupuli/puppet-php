# == Class: php::params
#
# PHP params class
#
# Configuration class for php module
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*version*]
#   The PHP version of PHP to install
#
# === Examples
#
#  include php::dev
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::params {

  $version = "installed"

  $web_service = "apache2"

  $extension_require = [
    Apt::Source['dotdeb'],
    Exec['apt_update']
  ]

  $extension_notify = [
    Service[$web_service]
  ]

  $extension_apc = {

  }

#    curl => {
#      package   => 'php5-curl',
#      provider  => undef,
#      require   => $extension_require,
#      notify    => $extension_notify
#    },
#    gd => {
#      package   => 'php5-gd',
#      provider  => undef,
#      require   => $extension_require,
#      notify    => $extension_notify
#    },
#    gearman => {
#      package   => 'php5-gearman',
#      provider  => undef,
#      require   => $extension_require,
#      notify    => $extension_notify
#    },
#    imagick => {
#      package   => 'php5-imagick',
#      provider  => undef,
#      require   => $extension_require,
#      notify    => $extension_notify
#    },
#    mcrypt => {
#      package   => 'php5-mcrypt',
#      provider  => undef,
#      require   => $extension_require,
#      notify    => $extension_notify
#    },
#    mysql => {
#      package   => 'php5-mysql',
#      provider  => undef,
#      require   => $extension_require,
#      notify    => $extension_notify
#    },
#    ssh2 => {
#      package   => 'php5-ssh2',
#      provider  => undef,
#      require   => $extension_require,
#      notify    => $extension_notify
#     },
#     uploadprogress => {
#      package   => 'uploadprogress',
#      provider  => 'pecl',
#      require   => [
#        Class['php::dev']
#      ],
#      notify    => $extension_notify
#    },
#    xdebug => {
#      package   => 'xdebug',
#      provider  => 'pecl',
#      require   => [
#        Class['php::dev']
#      ],
#      notify    => $extension_notify
#    },
#    igbinary => {
#      package   => 'igbinary',
#      provider  => 'pecl',
#      require   => [
#        Class['php::dev']
#      ],
#      notify    => $extension_notify
#    },
#    http => {
#      package   => 'pecl_http',
#      provider  => 'pecl',
#      require   => [
#        Class['php::dev'],
#        Package['libcurl4-openssl-dev'],
#        Package['libmagick++-dev']
#      ],
#      pipe      => 'echo "y
#      y
#      n"'
#    }
#  }

}
