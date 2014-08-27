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

  $fpm_service_enable = true
  $composer_source    = 'https://getcomposer.org/composer.phar'
  $composer_path      = '/usr/local/bin/composer'
  $composer_max_age   = 30

  case $::osfamily {
    'Debian': {
      $config_root         = '/etc/php5'
      $config_root_ini     = "${config_root}/mods-available"
      $apache_inifile      = "${config_root}/apache2/php.ini"
      $apache_package      = 'libapache2-mod-php5'
      $apache_service_name = 'apache2'
      $cli_inifile         = "${config_root}/cli/php.ini"
      $cli_package         = 'php5-cli'
      $dev_package         = 'php5-dev'
      $fpm_config_file     = "${config_root}/fpm/php-fpm.conf"
      $fpm_inifile         = "${config_root}/fpm/php.ini"
      $fpm_package         = 'php5-fpm'
      $fpm_pool_dir        = "${config_root}/fpm/pool.d"
      $fpm_service_name    = 'php5-fpm'
      $fpm_user            = 'www-data'
      $fpm_group           = 'www-data'
      $package_prefix      = 'php5-'
      $pear_package        = 'php-pear'
    }
    'Suse': {
      $config_root         = '/etc/php5'
      $config_root_ini     = "${config_root}/conf.d"
      $apache_inifile      = "${config_root}/apache2/php.ini"
      $apache_package      = 'apache2-mod_php5'
      $apache_service_name = 'apache2'
      $cli_inifile         = "${config_root}/cli/php.ini"
      $cli_package         = 'php5'
      $dev_package         = 'php5-devel'
      $fpm_config_file     = "${config_root}/fpm/php-fpm.conf"
      $fpm_inifile         = "${config_root}/fpm/php.ini"
      $fpm_package         = 'php5-fpm'
      $fpm_pool_dir        = "${config_root}/fpm/pool.d"
      $fpm_service_name    = 'php-fpm'
      $fpm_user            = 'nginx'
      $fpm_group           = 'nginx'
      $package_prefix      = 'php5-'
      $pear_package        = 'php5-pear'
    }
    'RedHat': {
      $config_root_ini     = '/etc/php.d'
      $apache_inifile      = "${config_root_ini}/apache2/php.ini"
      $apache_package      = 'php'
      $apache_service_name = 'httpd'
      $cli_inifile         = '/etc/php-cli.ini'
      $cli_package         = 'php-cli'
      $dev_package         = 'php-devel'
      $fpm_config_file     = '/etc/php-fpm.conf'
      $fpm_inifile         = "${config_root_ini}/fpm/php.ini"
      $fpm_package         = 'php-fpm'
      $fpm_pool_dir        = '/etc/php-fpm.d'
      $fpm_service_name    = 'php-fpm'
      $fpm_user            = 'www-data'
      $fpm_group           = 'www-data'
      $package_prefix      = 'php-'
      $pear_package        = 'php-pear'
    }
    'Gentoo': {
      $php_slot            = '5.5'
      $config_root_ini     = '/etc/php'
      $apache_inifile      = "${config_root_ini}/apache2-php${php_slot}/php.ini"
      $apache_package      = "dev-lang/php"
      $apache_service_name = 'apache2'
      $cli_inifile         = "${config_root_ini}/cli-php${php_slot}/php.ini"
      $cli_package         = $apache_package
      $fpm_config_file     = "${config_root_ini}/fpm-php${php_slot}/php-fpm.conf"
      $fpm_inifile         = "${config_root_ini}/fpm-php${php_slot}/php.ini"
      $fpm_package         = $apache_package
      $fpm_pool_dir        = '/etc/php-fpm.d'
      $fpm_service_name    = 'php-fpm'
      $fpm_user            = 'www'
      $fpm_group           = 'www'
      $package_prefix      = 'dev-php/pecl-'
      $pear_package        = 'dev-php/pear'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} only supports osfamily Debian, RedHat, Suse and Gentoo.\n
        If possible please fork this module, add the correct parameters in params.pp and open a pull request")
    }
  }
}
