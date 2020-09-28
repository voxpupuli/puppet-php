# @api private
# @summary Configure debian apt repo
#
# === Parameters
#
# [*external_repo_details*]
#   The repository details
#
class php::repo::debian (
  Hash[String[1], Hash] $external_repo_details = $php::external_repo_details,
) {
  assert_private()

  include 'apt'
  $external_repo_details.each |String $repository, Hash $repository_details| {
    apt::source { $repository:
      * => $repository_details,
    }
  }
}
