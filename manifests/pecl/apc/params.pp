class php::pecl::apc::params {

  $version        = $php::params::version
  $package        = 'php5-apc'
  $provider       = undef
  $require        = $php::params::extension_require
  $notify         = $php::params::extension_notify
  $config_file    = '/etc/php5/conf.d/20-apc.ini'
  $config_changes = {
    set => {
      '.anon/apc.enabled'           => 1,
      '.anon/apc.cache_by_default'  => 1,
      '.anon/apc.stat'              => 1,
      '.anon/apc.localcache'        => 1,
      '.anon/apc.localcache.size'   => 10000,
      '.anon/apc.shm_size'          => '64M',
      '.anon/apc.localcache'        => 1,
      '.anon/apc.localcache.size'   => 5000,
      '.anon/apc.apc.write_lock'    => 1,
      '.anon/apc.num_files_hint'    => 10000,
      '.anon/apc.user_entries_hint' => 40960,
      '.anon/apc.enable_cli'        => 0,
      '.anon/apc.file_update_protection' => 1,
      '.anon/apc.include_once_override' => 1
    }
  }

}
