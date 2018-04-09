# Configure debian apt repo
#
# === Parameters
#
# [*source*]
#   Mode of Repo Handling 'auto', 'native', 'sury', 'dotdeb', 'custom'
#
# [*apt_source*]
#   full Apt Source Hash defined in apt::source

class php::repo::debian(
  Enum['auto', 'native', 'sury', 'dotdeb', 'custom'] $source,
  Optional[Hash] $apt_source = undef,
  ### deprecated parameters below
  $location     = undef,
  $release      = undef,
  $repos        = undef,
  $include_src  = undef,
  $key          = undef,
  $dotdeb       = undef,
  $sury         = undef,
) {

  warning("we are here in repo setup")
  warning($sury)
  warning($dotdeb)
  warning($source)

  assert_private()

  ### deprecation code start ###########################################################################################
  if ($sury and $dotdeb) {
    fail('invalid setting, you cannot set both $sury and $dotdeb to true.')
  }

  if $sury != undef {
    deprecation('php::repo::debian sury', '$sury is deprecated and will be removed in the next major release. Please use $source instead.')
    warning('$sury is deprecated and will be removed in the next major release. Please use $source instead.') # TODO: remove
    if $sury {
      if ($source != 'auto' or $source != 'sury') {
        fail('invalid $source and $sury combination')
      }
      $_source = 'sury'
    }
  }
  if $dotdeb != undef {
    deprecation('php::repo::debian dotdeb', '$dotdeb is deprecated and will be removed in the next major release. Please use $source instead.')
    warning('$dotdeb is deprecated and will be removed in the next major release. Please use $source instead.')
    if $dotdeb {
      if ($source != 'auto' or $source != 'dotdeb') {
        fail('invalid $source and $dotdeb combination')
      }
      $_source = 'dotdeb'
    }
  }

  ## besseren check für undefined wenn deprecated stuff not used
  if  ($sury == undef or $sury == false) and ($dotdeb == undef or $dotdeb == false) {
    $_source = $source
  }

  if $location != undef or $release != undef or $repos != undef or $include_src != undef or $key != undef {
    deprecation('php::repo::debian $apt', '$location, $release, $repos, $include_src and $key are deprecated and will be removed in the next major release. Please use $repo hash instead.')
    warning('php::repo::debian $apt', '$location, $release, $repos, $include_src and $key are deprecated and will be removed in the next major release. Please use $repo hash instead.')

    $_apt_source = {
      location     => $location,
      release      => $release,
      repos        => $repos,
      include      => {
          'src' => $include_src,
          'deb' => true,
      },
      key          => $key,
    }
  } else {
    $_apt_source = $apt_source
  }
  ### deprecation code end ###########################################################################################

  #if () apt_source defined and source is not custom show warning

  include '::apt'
  case $_source {
    'native': { class { 'php::repo::debian::native': } }
    'auto':   { class { 'php::repo::debian::auto': } }
    'sury':   { class { 'php::repo::debian::sury': } }
    'dotdeb': { class { 'php::repo::debian::dotdeb': } }
    'custom': { class { 'php::repo::debian::custom': apt_source => $_apt_source } }
    # 'native': { class { 'php::repo::debian::native': }-> Anchor['php::begin'] }
    # 'auto':   { class { 'php::repo::debian::auto': }-> Anchor['php::begin'] }
    # 'sury':   { class { 'php::repo::debian::sury': }-> Anchor['php::begin'] }
    # 'dotdeb': { class { 'php::repo::debian::dotdeb': }-> Anchor['php::begin'] }
    # 'custom': { class { 'php::repo::debian::custom': apt_source => $_apt_source }-> Anchor['php::begin'] }
    default:  { fail("invalid source '${source}'") }
  }
}
