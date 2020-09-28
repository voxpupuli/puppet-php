# @api private
# @summary Configure debian apt repo
#
# @param [Hash] external_repo_details
#   The PHP versions the additional repositories support
# @option external_repo_details [Hash] :{}
#   default: empty Hash, default for OS from Hiera Data in module
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
