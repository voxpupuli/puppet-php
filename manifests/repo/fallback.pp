# @api private
# @summary the fallback class, throws an error, if called
class php::repo::fallback () {
  assert_private()
    $msg_no_repo = "No repo available for ${facts['os']['family']}/${facts['os']['name']}"

  fail($msg_no_repo)
}
