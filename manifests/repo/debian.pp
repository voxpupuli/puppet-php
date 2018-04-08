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
# [*key*]
#   Public key in apt::key format
#
class php::repo::debian(
  String           $location     = 'https://packages.sury.org/php',
  Optional[String] $release      = undef,
  String           $repos        = 'main',
  Boolean          $include_src  = false,
  Hash             $key          = {
    'id'     => 'DF3D585DB8F0EB658690A554AC0E47584A7A714D',
    'source' => 'https://packages.sury.org/php/apt.gpg',
  }
) {
  if $caller_module_name != $module_name {
    warning('php::repo::debian is private')
  }

  apt::source { 'php':
    location => $location,
    release  => $release,
    repos    => $repos,
    include  => { 'src' => $include_src },
    key      => $key,
  }
}
