# == Class: php::apt
#
# Configure dotdeb package repository
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
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::apt(
    $location     = 'http://packages.dotdeb.org',
    $release      = 'wheezy-php55',
    $repos        = 'all',
    $include_src  = false,
    $dotdeb       = true
  ) {

  apt::source { "source_php_$release":
    location    => $location,
    release     => $release,
    repos       => $repos,
    include_src => $include_src
  }

  if ($dotdeb) {
    exec { 'add_dotdeb_key':
      command => 'curl --silent "http://www.dotdeb.org/dotdeb.gpg" > /tmp/dotdeb.gpg && cat /tmp/dotdeb.gpg | apt-key add - && touch /var/local/dotdeb.gpg.done',
      creates => '/var/local/dotdeb.gpg.done'
    }

    Exec['add_dotdeb_key'] -> Apt::Source["source_php_$release"]
  }

}
