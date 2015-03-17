# Configure debian apt repo
#
# === Parameters
#
# [*location*]
#   Location of the apt repository
#
# [*release*]
#   Release of the apt repository
#
# [*repos*]
#   Apt repository names
#
# [*include_src*]
#   Add source source repository
#
# [*dotdeb*]
#   Enable special dotdeb handling
#
class php::repo::debian(
  $location     = 'http://packages.dotdeb.org',
  $release      = 'wheezy-php55',
  $repos        = 'all',
  $include_src  = false,
  $dotdeb       = true
) {

  if $caller_module_name != $module_name {
    warning('php::repo::debian is private')
  }

  include '::apt'

  apt::source { "source_php_${release}":
    location    => $location,
    release     => $release,
    repos       => $repos,
    include_src => $include_src,
  }

  if ($dotdeb) {
    # wheezy-php55 requires both repositories to work correctly
    # See: http://www.dotdeb.org/instructions/
    if $release == 'wheezy-php55' {
      apt::source { 'dotdeb-wheezy':
        location    => $location,
        release     => 'wheezy',
        repos       => $repos,
        include_src => $include_src,
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
