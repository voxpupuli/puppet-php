# @api private
# @summary Configure package repository
#
# @param [Boolean] manage_external_repo
#   manage an external package repository or not
# @option external_repo [Boolean] :false
#   default
# @option external_repo [Boolean] :true  
#
# @param [Array] external_repo_supported_php_versions
#   The PHP versions the additional repositories support
# @option external_repo_supported_php_versions [Array] :[]
#   default: empty array, default for OS from Hiera Data in module
#
# @param [Boolean] manage_internal_repo
#   manage an internal package repository, parameter is to control
#   app streams in CENTOS/RHEL/Fedora, Repos on FreeBSD or Archlinux
# @option external_repo [Boolean] :false
#   true
# @option external_repo [Boolean] :true   
#
# @param [Array] os_supported_php_versions
#   The PHP versions the OS supports by default, without any additional repositories,
#   on RHEL/CentOS and Fedora this includes app streams, on FreeBSD or Archlinux it manages Repos
# @option os_supported_php_versions [Array] :[]
#   default: empty array, default for OS from Hiera Data in module
# 
# @param [String] php_version
#   Set the PHP version to install
# @option php_version [String] :'7.4'
#   defaults: latest stable PHP Version available on php.net, default for OS from Hiera Data in module
#
class php::repo (
  Boolean $manage_internal_repo                         = $php::manage_internal_repo,
  Boolean $manage_external_repo                         = $php::manage_external_repo,
  Optional[Array] $external_repo_supported_php_versions = $php::external_repo_supported_php_versions,
  Array $os_supported_php_versions                      = $php::os_supported_php_versions,
  Optional[String[1]] $php_version                      = $php::php_version,

) {
  assert_private()
  $valid_external_php_version = $php_version in $external_repo_supported_php_versions
  $valid_os_php_version       = $php_version in $os_supported_php_versions

  if (($manage_internal_repo or $manage_external_repo) and ( $valid_os_php_version or $valid_external_php_version)) {
    case $facts['os']['name'] {
      'Archlinux':                  { contain 'php::repo::archlinux' }
      'FreeBSD':                    { contain 'php::repo::freebsd' }
      'RedHat', 'CentOS', 'Fedora': { contain 'php::repo::redhat' }
      'Debian', 'Ubuntu':           { contain 'php::repo::debian' }
      'OpenSuSE', 'SLES':           { contain 'php::repo::suse' }
      default:                      { contain 'php::repo::fallback' }
    }
  }
}
