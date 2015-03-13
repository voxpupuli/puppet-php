# == Class: php::params
#
# PHP params class
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
# Robin Gloster <robin.gloster@mayflower.de>
#
# === Copyright
#
# See LICENSE file
#
class php::params {

  $ensure              = 'latest'
  $fpm_service_enable  = true
  $composer_source     = 'https://getcomposer.org/composer.phar'
  $composer_path       = '/usr/local/bin/composer'
  $composer_max_age    = 30
  $pear_ensure         = 'latest'
  $pear_package_suffix = 'pear'
  $phpunit_source    = 'https://phar.phpunit.de/phpunit.phar'
  $phpunit_path      = '/usr/local/bin/phpunit'
  $phpunit_max_age   = 30

  case $::osfamily {
    'Debian': {
      $config_root             = '/etc/php5'
      if $::php_version == '' or versioncmp($::php_version, '5.4') >= 0 {
        $config_root_ini       = "${::php::params::config_root}/mods-available"
      } else {
        $config_root_ini       = "${::php::params::config_root}/conf.d"
      }
      $common_package_names    = []
      $common_package_suffixes = ['cli', 'common']
      $cli_inifile             = "${config_root}/cli/php.ini"
      $dev_package_suffix      = 'dev'
      $fpm_config_file         = "${config_root}/fpm/php-fpm.conf"
      $fpm_inifile             = "${config_root}/fpm/php.ini"
      $fpm_package_suffix      = 'fpm'
      $fpm_pool_dir            = "${config_root}/fpm/pool.d"
      $fpm_service_name        = 'php5-fpm'
      $fpm_user                = 'www-data'
      $fpm_group               = 'www-data'
      $package_prefix          = 'php5-'
      $compiler_packages       = 'build-essential'
      $manage_repos            = true
    }
    'Suse': {
      $config_root             = '/etc/php5'
      $config_root_ini         = "${config_root}/conf.d"
      $common_package_names    = ['php5']
      $common_package_suffixes = []
      $cli_inifile             = "${config_root}/cli/php.ini"
      $dev_package_suffix      = 'devel'
      $fpm_config_file         = "${config_root}/fpm/php-fpm.conf"
      $fpm_inifile             = "${config_root}/fpm/php.ini"
      $fpm_package_suffix      = 'fpm'
      $fpm_pool_dir            = "${config_root}/fpm/pool.d"
      $fpm_service_name        = 'php-fpm'
      $fpm_user                = 'wwwrun'
      $fpm_group               = 'www'
      $package_prefix          = 'php5-'
      $manage_repos            = true
      case $::operatingsystem {
        'SLES': {
          $compiler_packages = []
        }
        'OpenSuSE': {
          $compiler_packages = 'devel_basis'
        }
        default: {
          fail("Unsupported operating system ${::operatingsystem}")
        }
      }
    }
    'RedHat': {
      $config_root_ini         = '/etc/php.d'
      $common_package_names    = []
      $common_package_suffixes = ['cli', 'common']
      $cli_inifile             = '/etc/php-cli.ini'
      $dev_package_suffix      = 'devel'
      $fpm_config_file         = '/etc/php-fpm.conf'
      $fpm_inifile             = '/etc/php.ini'
      $fpm_package_suffix      = 'fpm'
      $fpm_pool_dir            = '/etc/php-fpm.d'
      $fpm_service_name        = 'php-fpm'
      $fpm_user                = 'apache'
      $fpm_group               = 'apache'
      $package_prefix          = 'php-'
      $compiler_packages       = ['gcc', 'gcc-c++', 'make']
      $manage_repos            = false
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily}")
    }
  }
}
