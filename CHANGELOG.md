# Changelog

## 2.0.0
 * Remove augeas and switch to puppetlabs/inifile for configs
   * Old: `settings => [‘set PHP/short_open_tag On‘]`
   * New: `settings => {‘PHP/short_open_tag’ => ‘On‘}`
 * The parameter `config` of `php::extension` resources is now called `settings`
 * The parameters `user` and `group` of `php::fpm` have been moved to `php::fpm::config`

## 1.1.2
 * SLES: PHP 5.5 will now be installed
 * Pecl extensions now autoload the .so based on $name instead of $title

## 1.1.1
 * some nasty bugs with the pecl php::extension provider were fixed
 * php::extension now has a new pecl_source parameter for specifying custom
   source channels for the pecl provider

## 1.1.0
 * add phpunit to main class
 * fix variable access for augeas

## 1.0.2
 * use correct suse apache service name
 * fix anchoring of augeas

## 1.0.1
 * fixes #9 undefined pool_base_dir

## 1.0.0
Initial release

