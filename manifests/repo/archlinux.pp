# @api private
# @summary Configure archlinux repo
#
# @param [Hash] external_repo_details
#   The PHP versions the additional repositories support
# @option external_repo_details [Hash] :{}
#   default: empty Hash, default for OS from Hiera Data in module
#
class php::repo::archlinux (
  Hash[String[1], Hash] $external_repo_details = $php::external_repo_details,
) {
  assert_private()
}
