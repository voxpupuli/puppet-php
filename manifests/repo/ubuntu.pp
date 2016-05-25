# Configure ubuntu ppa
#
# === Parameters
#
# [*version*]
#   PHP version to manage (e.g. 5.6)
#
# [*ppa*]
#   Use a specific PPA, e.g "ondrej/php5-5.6" (without the "ppa:")
#
class php::repo::ubuntu (
  $version   = undef,
  $ppa       = undef,
) {
  include '::apt'

  if($version == undef) {
    $version_real = '5.5'
  } else {
    $version_real = $version
  }

  validate_re($version_real, '^\d\.\d')

  $version_repo = $version_real ? {
    '5.4' => 'ondrej/php5-oldstable',
    '5.5' => 'ondrej/php',
    '5.6' => 'ondrej/php',
    '7.0' => 'ondrej/php'
  }

  if ($version != undef and $ppa != undef) {
    fail('Only one of $version and $ppa can be specified.')
  }

  if ($ppa) {
    ::apt::ppa { "ppa:${ppa}":
      before => [Class['::php::packages'],Class['::php::pear'],Class['::php::dev']],
    }
  } else {
    ::apt::ppa { "ppa:${version_repo}":
      before => [Class['::php::packages'],Class['::php::pear'],Class['::php::dev']],
    }
  }
}
