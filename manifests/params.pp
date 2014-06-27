# == Class: php::params
#
# PHP params class
#
# Configuration class for php module
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*ensure*]
#   The PHP ensure of PHP to install
#
# === Examples
#
#  include php::dev
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
      $apache_inifile      = "${config_root}/apache2/php.ini"
      $apache_package      = 'libapache2-mod-php5'
      $apache_service_name = 'apache2'
      $cli_inifile         = "${config_root}/cli/php.ini"
      $cli_package         = 'php5-cli'
      $config_root         = '/etc/php5'
      $config_root_ini     = "${config_root}/mods-available"
      $dev_package         = 'php5-dev'
      $fpm_inifile         = "${config_root}/fpm/php.ini"
      $fpm_package         = 'php5-fpm'
      $fpm_pool_dir        = "${config_root}/fpm/pool.d"
      $fpm_service_name    = 'php5-fpm'
      $fpm_user            = 'www-data'
      $package_prefix      = 'php5-'
      $pear_package        = 'php-pear'
    }
    'Suse': {
      $apache_inifile      = "${config_root}/apache2/php.ini"
      $apache_package      = 'apache2-mod_php5'
      $apache_service_name = 'apache2'
      $cli_inifile         = "${config_root}/cli/php.ini"
      $cli_package         = 'php5'
      $config_root         = '/etc/php5'
      $config_root_ini     = "${config_root}/conf.d"
      $dev_package         = 'php5-devel'
      $fpm_inifile         = "${config_root}/fpm/php.ini"
      $fpm_package         = 'php5-fpm'
      $fpm_pool_dir        = "${config_root}/fpm/pool.d"
      $fpm_service_name    = 'php-fpm'
      $fpm_user            = 'nginx'
      $package_prefix      = 'php5-'
      $pear_package        = 'php5-pear'
    }
    'RedHat': {
      $apache_inifile      = "${config_root}/apache2/php.ini"
      $apache_package      = 'php'
      $apache_service_name = 'httpd'
      $cli_inifile         = '/etc/php-cli.ini'
      $cli_package         = 'php-cli'
      $config_root_ini     = '/etc/php.d'
      $dev_package         = 'php-devel'
      $fpm_inifile         = '/etc/php-fpm.conf'
      $fpm_package         = 'php-fpm'
      $fpm_pool_dir        = '/etc/php-fpm.d'
      $fpm_service_name    = 'php-fpm'
      $fpm_user            = 'www-data'
      $package_prefix      = 'php-'
      $pear_package        = 'php-pear'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} only supports osfamily Debian, and Suse.\n
        If possible please fork this module, add the correct parameters in params.pp and open a pull request")
    }
  }
}
