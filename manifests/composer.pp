# Install composer package manager
#
# === Parameters
#
# [*source*]
#   Holds URL to the Composer source file
#
# [*path*]
#   Holds path to the Composer executable
#
# [*environment*]
#   Environment variables for settings such as http_proxy, https_proxy, or ftp_proxy
#
# [*manage_curl*]
#   Should we ensure curl is installed or do you want to manage that?
#
# [*auto_update*]
#   Defines if composer should be auto updated
#
# [*max_age*]
#   Defines the time in days after which an auto-update gets executed
#
# [*root_group*]
#   UNIX group of the root user
#
class php::composer (
  $source      = $::php::params::composer_source,
  $path        = $::php::params::composer_path,
  $environment = undef,
  $manage_curl = true,
  $auto_update = true,
  $max_age     = $::php::params::composer_max_age,
  $root_group  = $::php::params::root_group,
) inherits ::php::params {

  if $caller_module_name != $module_name {
    warning('php::composer is private')
  }

  validate_string($source)
  validate_absolute_path($path)
  validate_bool($auto_update)
  validate_re("x${max_age}", '^x\d+$')

  if $manage_curl { ensure_packages(['curl']) }

  exec { 'download composer':
    command     => "curl -L ${source} -o ${path}",
    environment => $environment,
    creates     => $path,
    path        => ['/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/',
                    '/usr/local/bin', '/usr/local/sbin'],
    require     => [Class['::php::cli'],Package['curl']],
  } ->
  file { $path:
    mode  => '0555',
    owner => root,
    group => $root_group,
  }

  if $auto_update {
    class { '::php::composer::auto_update':
      max_age     => $max_age,
      source      => $source,
      path        => $path,
      environment => $environment,
    }
  }
}
