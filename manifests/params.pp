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

  $config_root        = '/etc/php5'
  $augeas_contrib_dir = '/usr/share/augeas/lenses/contrib'
  $cli_inifile        = '/etc/php5/cli/php.ini'
  $fpm_package        = 'php5-fpm'
  $fpm_service_enable = true
  $fpm_inifile        = '/etc/php5/fpm/php.ini'
  $apache_inifile     = '/etc/php5/apache2/php.ini'
  $composer_source    = 'https://getcomposer.org/composer.phar'
  $composer_path      = '/usr/local/bin/composer'
  $composer_max_age   = 30

  case $::osfamily {
    'Debian': {
      $config_root_ini     = "${config_root}/mods-available"
      $fpm_service_name    = 'php5-fpm'
      $fpm_user            = 'www-data'
      $dev_package         = 'php5-dev'
      $cli_package         = 'php5-cli'
      $pear_package        = 'php-pear'
      $apache_package      = 'libapache2-mod-php5'
      $apache_service_name = 'apache2'
    }
    'Suse': {
      $config_root_ini     = "${config_root}/conf.d"
      $fpm_service_name    = 'php-fpm'
      $fpm_user            = 'nginx'
      $dev_package         = 'php5-devel'
      $cli_package         = 'php5'
      $pear_package        = 'php5-pear'
      $apache_package      = 'apache2-mod_php5'
      $apache_service_name = 'httpd'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} only supports osfamily Debian, and Suse.\n
        If possible please fork this module, add the correct parameters in params.pp and open a pull request")
    }
  }
}
