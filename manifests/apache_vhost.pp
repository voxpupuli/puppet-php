# Configures an apache vhost for php
#
# === Parameters
#
# [*vhost*]
#   The vhost address
#
# [*docroot*]
#   The vhost docroot
#
# [*port*]
#   The vhost port
#
# [*default_vhost*]
#   defines if vhost is the default vhost
#
# [*fastcgi_socket*]
#   address of the fastcgi socket
#
define php::apache_vhost (
  String[1] $vhost              = 'example.com',
  Stdlib::Absolutepath $docroot = '/var/www',
  Integer[1] $port              = 80,
  Boolean $default_vhost        = true,
  String[1] $fastcgi_socket     = 'fcgi://127.0.0.1:9000/$1'
) {
  ::apache::vhost { $vhost:
    docroot         => $docroot,
    default_vhost   => $default_vhost,
    port            => $port,
    override        => 'all',
    custom_fragment => "ProxyPassMatch ^/(.*\\.php(/.*)?)$ ${fastcgi_socket}",
  }
}
