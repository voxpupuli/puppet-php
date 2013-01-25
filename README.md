puppet-php
==========

Puppet module to manage PHP on debian using dotdeb apt repository

Right now only supports dotdeb on debian squeeze, should be fairly easy to modify if needed though

Puppet forge URL: http://forge.puppetlabs.com/nodes/php

### Installation

```
puppet module install nodes/php
```

or simply clone the repository in your `module_path` (the folder must be named **php**)

### Setup

There is little to no class dependency between all classes

To ensure that things happen in a predictable order please use the example below to ensure that extensions are installed before they are configured

```
# Install extensions; Configure extensions; Reload apache if changed
Php::Extension <| |> -> Php::Config <| |> ~> Service["apache2"]
```

If you rely on `dotdeb` (default behavior) you also want to make sure that the `php::apt` class is loaded and `apt` has been updated (`apt-get update`) before packages are installed

```
# Install sources; Update sources; Install packages
Apt::Source <| |> ~> Exec['apt_update'] -> Package <| |>
```

Using the Pecl package provider requires the `php5-dev` and `build-essential` package to be installed beforehand

### Example configuration of the module.

It will install CLI, mod_php for apache, dev packages, pear and APC

```
$php_version = '5.4.11-1~dotdeb.0'

include php
include php::apt

class {
  'php::cli':
    ensure => $php_version;
  'php::apache':
    ensure => $php_version;
  'php::dev':
    ensure => $php_version;
  'php::pear':
    ensure => $php_version;
  'php::extension::apc':
    ensure => $php_version;
}
```

### Package providers

The module provides a `pear` and `pecl` provider

#### Pear package example

```
package { 'pear.phpunit.de/PHPUnit':
	ensure 	 => installed,
	provider => pear;
}
```

#### Pecl package example

```
package { 'igbinary':
	ensure   => installed,
	provider => pecl;
}
```

### Installing packages

It's quite simple to install packages not included in the package, simply use `php::extension`

```
php::extension { 'platform-independent-name':
  ensure   => $ensure,		# Same as Package { ensure }
  package  => $package,		# Package name as defined in the package provider
  provider => $provider;	# Provider used to install (pecl, pearl, (default)undef)
}

# same as

package { $package:			# Package name as defined in the package provider
	ensure   => $ensure,	# Same as Package { ensure }
	provider => $provider;	# Provider used to install (pecl, pearl, (default)undef)
}
```

The advantage of using `php::extension` over `package` is the anchor of dependency mentioned in **Setup**

Packages from a custom `pear` channel is also supported nicely

```
package { 'pear.phpunit.de/PHPUnit':
	ensure   => '3.7.12', # Same as Package { ensure }
	provider => pear,
	require  => Exec['php::pear::auto_discover'];
}
```

If you want to auto-discover channels, make sure to `require` `Exec['php::pear::auto_discover']`

### Configure packages

Modifying php configuration is also baked right now

Simply use `php::config` to modify your ini files

```
php::config { '$unique-name':
 	config_file    => '$full_path_to_ini_file'
	config_changes => {
		set => {
			'.anon/apc.enabled' => 1
		}
	}
}

# same as

augeas { "php-${uniqie-name}-config":
	context => "/files${full_path_to_ini_file}",
	changes => {
		"set '.anon/apc.enabled' '1'"
	}
}
```

`config_changes` is a key / value `augeas` hash

Currently `config_changes` only support the type `set` in augeas

### PHP SAPIs

By default the module comes with support for mod_php (`php::apache`) and cli `php::cli`

### PHP modules

The following modules are implemented by default:

* apc (php::extension::apc)
* curl (php::extension::curl)
* gd (php::extension::gd)
* gearman (php::extension::gearman)
* http (php::extension::http)
* igbinary (php::extension::igbinary)
* imagick (php::extension::imagick)
* mcrypt (php::extension::mcrypt)
* mysql (php::extension::mysql)
* redis (php::extension::redis)
* ssh2 (php::extension::ssh2)
* uploadprogress (php::extension::uploadprogress)
* xdebug (php::extension::xdebug)

each of them are located in the `php::extension` namespace

### Packages

The following PHP related packages come build in too

* Composer (php::composer)
* phpunit (php::phpunit)
