# Install phpunit, PHP testing framework
#
# === Parameters
#
# [*source*]
#   Holds URL to the phpunit source file
#
# [*path*]
#   Holds path to the phpunit executable
#
# [*auto_update*]
#   Defines if phpunit should be auto updated
#
# [*max_age*]
#   Defines the time in days after which an auto-update gets executed
#
class php::phpunit (
  String $source             = 'https://phar.phpunit.de/phpunit.phar',
  Stdlib::Absolutepath $path = '/usr/local/bin/phpunit',
  String[1] $root_group      = $php::params::root_group,
  Boolean $auto_update       = true,
  Integer $max_age           = 30,
) inherits php::params {
  assert_private()

  stdlib::ensure_packages(['wget'])

  exec { 'download phpunit':
    command => "wget ${source} -O ${path}",
    creates => $path,
    path    => ['/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/', '/usr/local/bin', '/usr/local/sbin'],
    require => [Class['php::cli'],Package['wget']],
  }
  -> file { $path:
    mode  => '0555',
    owner => root,
    group => $root_group,
  }

  if $auto_update {
    class { 'php::phpunit::auto_update':
      max_age => $max_age,
      source  => $source,
      path    => $path,
    }
  }
}
