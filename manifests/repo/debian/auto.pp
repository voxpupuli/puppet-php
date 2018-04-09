class php::repo::debian::auto(
) {
  if $caller_module_name != $module_name {
    warning('php::repo::debian is private')
  }

  fail('not implemented yet')
}
