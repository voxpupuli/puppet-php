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
# [*php_version*]
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

  $php_version = "installed"

  $web_service = "apache2"

  $extension_require = [
    Apt::Source['dotdeb'],
    Exec['apt_update']
  ]

  $extension_notify = [
    Service[$web_service]
  ]

  $extensions = {
    apc => {
      package     => "php5-apc",
      provider    => undef,
      require     => $extension_require,
      notify      => $extension_notify,
      config_file => '/etc/php5/conf.d/20-apc.ini',
      config_changes => {
        set => {
          '.anon/apc.enabled'           => 1,
          '.anon/apc.cache_by_default'  => 1,
          '.anon/apc.stat'              => 1,
          '.anon/apc.localcache'        => 1,
          '.anon/apc.localcache.size'   => 10000,
          '.anon/apc.shm_size'          => '64M',
          '.anon/apc.localcache'        => 1,
          '.anon/apc.localcache.size'   => 5000,
          '.anon/apc.apc.write_lock'    => 1,
          '.anon/apc.num_files_hint'    => 10000,
          '.anon/apc.user_entries_hint' => 40960,
          '.anon/apc.enable_cli'        => 0,
          '.anon/apc.file_update_protection' => 1,
          '.anon/apc.include_once_override' => 1
        }
      }
    },
    curl => {
      package   => 'php5-curl',
      provider  => undef,
      require   => $extension_require,
      notify    => $extension_notify
    },
    gd => {
      package   => 'php5-gd',
      provider  => undef,
      require   => $extension_require,
      notify    => $extension_notify
    },
    gearman => {
      package   => 'php5-gearman',
      provider  => undef,
      require   => $extension_require,
      notify    => $extension_notify
    },
    imagick => {
      package   => 'php5-imagick',
      provider  => undef,
      require   => $extension_require,
      notify    => $extension_notify
    },
    mcrypt => {
      package   => 'php5-mcrypt',
      provider  => undef,
      require   => $extension_require,
      notify    => $extension_notify
    },
    mysql => {
      package   => 'php5-mysql',
      provider  => undef,
      require   => $extension_require,
      notify    => $extension_notify
    },
    ssh2 => {
      package   => 'php5-ssh2',
      provider  => undef,
      require   => $extension_require,
      notify    => $extension_notify
     },
     uploadprogress => {
      package   => 'uploadprogress',
      provider  => 'pecl',
      require   => [
        Class['php::dev']
      ],
      notify    => $extension_notify
    },
    xdebug => {
      package   => 'xdebug',
      provider  => 'pecl',
      require   => [
        Class['php::dev']
      ],
      notify    => $extension_notify
    },
    igbinary => {
      package   => 'igbinary',
      provider  => 'pecl',
      require   => [
        Class['php::dev']
      ],
      notify    => $extension_notify
    },
    http => {
      package   => 'pecl_http',
      provider  => 'pecl',
      require   => [
        Class['php::dev'],
        Package['libcurl4-openssl-dev'],
        Package['libmagick++-dev']
      ],
      pipe      => 'echo "y
      y
      n"'
    }
  }

}
