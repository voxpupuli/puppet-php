# Install composer package manager
#
# === Parameters
#
# [*max_age*]
#   Defines number of days after which Composer should be updated
#
# [*source*]
#   Holds URL to the Composer source file
#
# [*path*]
#   Holds path to the Composer executable
#
# [*channel*]
#   Holds the Update channel (stable|preview|snapshot|1|2)
#
# [*proxy_type*]
#    proxy server type (none|http|https|ftp)
#
# [*proxy_server*]
#   specify a proxy server, with port number if needed. ie: https://example.com:8080.
#
#
# === Examples
#
#  include php::composer::auto_update
#  class { "php::composer::auto_update":
#    "max_age" => 90
#  }
#
class php::composer::auto_update (
  Integer[1] $max_age,
  String[1] $source,
  Stdlib::Absolutepath $path,
  Php::ComposerChannel  $channel = 'stable',
  Optional[String[1]] $proxy_type   = undef,
  Optional[String[1]] $proxy_server = undef,
) {
  assert_private()
  if $proxy_server {
    if $proxy_server =~ Stdlib::HTTPUrl {
      $_proxy_server = $proxy_server
    } else {
      if $proxy_type {
        $_proxy_server = "${proxy_type}://${proxy_server}"
      } else {
        fail('proxy_type must be defined if proxy_server is not full URL (https://example.com)')
      }
    }
    $env = [
      'HOME=/root',
      "http_proxy=${_proxy_server}",
      "https_proxy=${_proxy_server}",
    ]
  } else {
    $env = ['HOME=/root']
  }

  exec { 'update composer':
    # touch binary when an update is attempted to update its mtime for idempotency when no update is available
    command     => "${path} --no-interaction --quiet self-update --${channel}; touch ${path}",
    environment => $env,
    onlyif      => "test `find '${path}' -mtime +${max_age}`",
    path        => ['/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/', '/usr/local/bin', '/usr/local/sbin'],
    require     => [File[$path], Class['php::cli']],
  }
}
