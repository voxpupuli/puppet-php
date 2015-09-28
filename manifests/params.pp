# PHP params class
#
class php::params {

  $ensure              = 'present'
  $fpm_service_enable  = true
  $composer_source     = 'https://getcomposer.org/composer.phar'
  $composer_path       = '/usr/local/bin/composer'
  $composer_max_age    = 30
  $pear_ensure         = 'present'
  $pear_package_suffix = 'pear'
  $phpunit_source    = 'https://phar.phpunit.de/phpunit.phar'
  $phpunit_path      = '/usr/local/bin/phpunit'
  $phpunit_max_age   = 30

  case $::osfamily {
    'Debian': {
      $config_root             = '/etc/php5'
      $config_root_ini         = "${::php::params::config_root}/mods-available"
      $common_package_names    = []
      $common_package_suffixes = ['cli', 'common']
      $cli_inifile             = "${config_root}/cli/php.ini"
      $dev_package_suffix      = 'dev'
      $fpm_pid_file            = '/var/run/php5-fpm.pid'
      $fpm_config_file         = "${config_root}/fpm/php-fpm.conf"
      $fpm_error_log           = '/var/log/php5-fpm.log'
      $fpm_inifile             = "${config_root}/fpm/php.ini"
      $fpm_package_suffix      = 'fpm'
      $fpm_pool_dir            = "${config_root}/fpm/pool.d"
      $fpm_service_name        = 'php5-fpm'
      $fpm_user                = 'www-data'
      $fpm_group               = 'www-data'
      $package_prefix          = 'php5-'
      $compiler_packages       = 'build-essential'
      $root_group              = 'root'

      case $::operatingsystem {
        'Debian': {
          $manage_repos = $::lsbdistcodename == 'wheezy'
        }

        'Ubuntu': {
          $manage_repos = true
        }

        default: {
          $manage_repos = false
        }
      }
    }

    'Suse': {
      $config_root             = '/etc/php5'
      $config_root_ini         = "${config_root}/conf.d"
      $common_package_names    = ['php5']
      $common_package_suffixes = []
      $cli_inifile             = "${config_root}/cli/php.ini"
      $dev_package_suffix      = 'devel'
      $fpm_pid_file            = '/var/run/php5-fpm.pid'
      $fpm_config_file         = "${config_root}/fpm/php-fpm.conf"
      $fpm_error_log           = '/var/log/php5-fpm.log'
      $fpm_inifile             = "${config_root}/fpm/php.ini"
      $fpm_package_suffix      = 'fpm'
      $fpm_pool_dir            = "${config_root}/fpm/pool.d"
      $fpm_service_name        = 'php-fpm'
      $fpm_user                = 'wwwrun'
      $fpm_group               = 'www'
      $package_prefix          = 'php5-'
      $manage_repos            = true
      $root_group              = 'root'
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
      $fpm_pid_file            = '/var/run/php-fpm/php-fpm.pid'
      $fpm_config_file         = '/etc/php-fpm.conf'
      $fpm_error_log           = '/var/log/php-fpm/error.log'
      $fpm_inifile             = '/etc/php.ini'
      $fpm_package_suffix      = 'fpm'
      $fpm_pool_dir            = '/etc/php-fpm.d'
      $fpm_service_name        = 'php-fpm'
      $fpm_user                = 'apache'
      $fpm_group               = 'apache'
      $package_prefix          = 'php-'
      $compiler_packages       = ['gcc', 'gcc-c++', 'make']
      $manage_repos            = false
      $root_group              = 'root'
    }
    'FreeBSD': {
      $config_root             = '/usr/local/etc'
      $config_root_ini         = "${config_root}/php"
      # No common packages, because the required PHP base package will be
      # pulled in as a dependency. This preserves the ability to choose
      # any available PHP version by setting the 'package_prefix' parameter.
      $common_package_names    = []
      $common_package_suffixes = ['extensions']
      $cli_inifile             = "${config_root}/php-cli.ini"
      $dev_package_suffix      = undef
      $fpm_pid_file            = '/var/run/php-fpm.pid'
      $fpm_config_file         = "${config_root}/php-fpm.conf"
      $fpm_error_log           = '/var/log/php-fpm.log'
      $fpm_inifile             = "${config_root}/php.ini"
      $fpm_package_suffix      = undef
      $fpm_pool_dir            = "${config_root}/php-fpm.d"
      $fpm_service_name        = 'php-fpm'
      $fpm_user                = 'www'
      $fpm_group               = 'www'
      $package_prefix          = 'php56-'
      $compiler_packages       = ['gcc']
      $manage_repos            = false
      $root_group              = 'wheel'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily}")
    }
  }
}
