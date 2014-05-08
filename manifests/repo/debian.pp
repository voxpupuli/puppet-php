# == Class: php::repo::debian
#
# Configure debian apt repo
#
# === Parameters
#
# [*location*]
#   location of the apt repository
# 
# [*release*]
#   release of the apt repository
# 
# [*repos*]
#   apt repository names
# 
# [*include_src*]
#   add source source repository 
# 
# [*dotdeb*]
#   enable special dotdeb handling
# 
# === Variables
#
# No variables
#
# === Examples
#
#  include php::repo::debian
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
# Robin Gloster <robin.gloster@mayflower.de>
#
# === Copyright
#
# See LICENSE file
#
class php::repo::debian(
  $location     = 'http://packages.dotdeb.org',
  $release      = 'wheezy-php55',
  $repos        = 'all',
  $include_src  = false,
  $dotdeb       = true
) {

  if $caller_module_name != $module_name {
    warning("${name} is not part of the public API of the ${module_name} module and should not be directly included in the manifest.")
  }

  apt::source { "source_php_${release}":
    location    => $location,
    release     => $release,
    repos       => $repos,
    include_src => $include_src
  }

  if ($dotdeb) {
    # wheezy-php55 requires both repositories to work correctly
    # See: http://www.dotdeb.org/instructions/
    if $release == 'wheezy-php55' {
      apt::source { 'dotdeb-wheezy':
        location    => $location,
        release     => 'wheezy',
        repos       => $repos,
        include_src => $include_src
      }
    }

    exec { 'add_dotdeb_key':
      command => 'curl -L --silent "http://www.dotdeb.org/dotdeb.gpg" | apt-key add -',
      unless  => 'apt-key list | grep -q dotdeb',
      path    => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ];
    }

    Exec['add_dotdeb_key'] -> Apt::Source["source_php_${release}"]
  }
}
