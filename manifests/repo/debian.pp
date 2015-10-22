# Configure debian apt repo
#
# === Parameters
#
# [*location*]
#   Location of the apt repository
#
# [*release*]
#   Releases of the apt repository. Can be a string with the release name, or an
#   array of strings with multiple releases.
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
# [*dotdeb*]
#   Enable special dotdeb handling
#
class php::repo::debian(
  $location     = 'http://packages.dotdeb.org',
  $release      = 'wheezy-php55',
  $repos        = 'all',
  $include_src  = false,
  $key          = {
    'id'     => '6572BBEF1B5FF28B28B706837E3F070089DF5277',
    'source' => 'http://www.dotdeb.org/dotdeb.gpg',
  },
  $dotdeb       = true,
) {

  if $caller_module_name != $module_name {
    warning('php::repo::debian is private')
  }

  include '::apt'

  create_resources(::apt::key, { 'php::repo::debian' => {
    key => $key['id'], key_source => $key['source'],
  }})

  define php_apt_source($location, $repos, $include_src) {
    ::apt::source { "source_php_${title}":
      location    => $location,
      release     => $title,
      repos       => $repos,
      include_src => $include_src,
      require     => Apt::Key['php::repo::debian'],
    }
  }

  php_apt_source { $release:
    location    => $location,
    repos       => $repos,
    include_src => $include_src,
  }

  if ($dotdeb) {
    # Dotdeb requires the general 'wheezy' release as well.
    # See: http://www.dotdeb.org/instructions/
    ::apt::source { 'dotdeb-wheezy':
      location    => $location,
      release     => 'wheezy',
      repos       => $repos,
      include_src => $include_src,
    }
  }
}
