# Install and configure php apache settings
#
# === Parameters
#
# [*inifile*]
#   The path to the ini php-apache ini file
#
# [*settings*]
#   Hash with nested hash of key => value to set in inifile
#
class php::apache_config(
  Stdlib::Absolutepath $inifile = $php::params::apache_inifile,
  Hash $settings                = {}
) inherits php::params {

  assert_private()

  $real_settings = lookup('php::apache::settings', Hash, {'strategy' => 'deep', 'merge_hash_arrays' => true}, $settings)

  php::config { 'apache':
    file   => $inifile,
    config => $real_settings,
  }
}
