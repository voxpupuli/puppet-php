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
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian "Jippi" Winther, unless otherwise noted.
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
      command => 'curl --silent "http://www.dotdeb.org/dotdeb.gpg" | apt-key add -',
      unless => 'apt-key list | grep -q dotdeb'
    }

    Exec['add_dotdeb_key'] -> Apt::Source["source_php_$release"]
  }

}
