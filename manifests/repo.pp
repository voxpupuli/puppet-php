# @api private
# @summary Configure package repository
#
class php::repo (
  Boolean $external_repo                                = $php::external_repo,
  Optional[String[1]] $php_version                      = $php::php_version,
  Optional[Array] $external_repo_supported_php_versions = $php::external_repo_supported_php_versions,
) {
  assert_private()

  if ($external_repo and $php_version in $external_repo_supported_php_versions) {
    case $facts['os']['name'] {
      'RedHat', 'CentOS': { contain 'php::repo::redhat' }
      'Debian', 'Ubuntu': { contain 'php::repo::debian' }
      default:            { contain 'php::repo::fallback' }
    }
  }
}
