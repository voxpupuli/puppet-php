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
class php::apt {

  apt::source { 'dotdeb':
    location    => 'http://packages.dotdeb.org',
    release     => 'squeeze-php54',
    repos       => 'all',
    include_src => true,
  }

  exec { 'add_dotdeb_key':
    command => 'curl --silent "http://www.dotdeb.org/dotdeb.gpg" > /tmp/dotdeb.gpg && cat /tmp/dotdeb.gpg | sudo apt-key add - && touch /var/local/dotdeb.gpg.done',
    creates => '/var/local/dotdeb.gpg.done';
  }

  Exec['add_dotdeb_key']
    -> Apt::Source['dotdeb']
    ~> Exec['apt_update']

}
