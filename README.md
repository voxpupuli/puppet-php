puppet-php
==========

Puppet module to manage PHP on debian (optionally with dotdeb) & ubuntu

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
Package['php5-dev'] -> Php::Extension <| |> -> Php::Config <| |> ~> Service["apache2"]
```

If you rely on `dotdeb` you also want to make sure that the `php::apt` class is loaded and `apt` has been updated (`apt-get update`) before packages are installed

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
    ensure   => installed,
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

#### deb package example

```
  package { "libgearman":
    ensure    =>  "latest",
    provider  =>  "dpkg",
    source    =>  "/path/to/libgearman8_1.1.7-1_amd64.deb",
  }
```

### Installing packages

It's quite simple to install packages not included in the package, simply use `php::extension`

```
php::extension { 'platform-independent-name':
  ensure   => $ensure,      # Same as Package { ensure }
  package  => $package,     # Package name as defined in the package provider
  provider => $provider;    # Provider used to install (pecl, pear, (default)undef)
}

# same as

package { $package:         # Package name as defined in the package provider
    ensure   => $ensure,    # Same as Package { ensure }
    provider => $provider;  # Provider used to install (pecl, pear, (default)undef)
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
    inifile  => '$full_path_to_ini_file'
    settings => {
        set => {
            '.anon/apc.enabled' => 1
        }
    }
}

# same as

augeas { "php-${unique-name}-config":
    context => "/files${full_path_to_ini_file}",
    changes => {
        "set '.anon/apc.enabled' '1'"
    }
}

# or to modify php.ini
# note that keys outside of the sections in php.ini file
# should be referenced by PHP and not .anon

php::config { '$unique-name':
  inifile  => '$full_path_to_php.ini_file',
  settings => {
    set => {
    'Date/date.timezone' => "UTC",
    'PHP/short_open_tag' => "Off",
    }
  }
}

# same as

augeas { "php-${unique-name}-config":
    context => "/files${full_path_to_php.ini_file}",
    changes => {
        "set 'Date/date.timezone' 'UTC'",
        "set 'PHP/short_open_tag' 'Off'"
    }
}

```

`settings` is a key / value `augeas` hash

Currently `settings` only support the type `set` in augeas

To remove a config key you might use
```
augeas { "remove-disable_functions":
  context => "/files/etc/php5/fpm/php.ini/PHP",
  changes => [
    "rm disable_functions"
  ];
}
```

The advantage of using `php::config` over `augeas` is the anchor of dependency mentioned in **Setup**

### PHP SAPIs

By default the module comes with support for mod_php (`php::apache`), cli `php::cli` and fpm `php::fpm`

### PHP modules

The following modules are implemented by default:

* apc (php::extension::apc)
* curl (php::extension::curl)
* gd (php::extension::gd)
* gearman (php::extension::gearman)
* http (php::extension::http)
* igbinary (php::extension::igbinary)
* imagick (php::extension::imagick)
* imap (php::extension::imap)
* ldap (php::extension::ldap)
* mcrypt (php::extension::mcrypt)
* mysql (php::extension::mysql)
* pgsql (php::extension::pgsql)
* redis (php::extension::redis)
* ssh2 (php::extension::ssh2)
* uploadprogress (php::extension::uploadprogress)
* xdebug (php::extension::xdebug)

each of them are located in the `php::extension` namespace

### Packages

The following PHP related packages come build in too

* Composer (php::composer)
* phpunit (php::phpunit)

### Note on upgrading with "puppet install" prior to version 0.6.2
If you are using `puppet module` to install from Puppet Forge and want to upgrade from a version prior to 0.6.1, you will need to use `puppet module install --force` to resolve an issue with the package name not matching what puppet expects to find. Future updates should work as expected.

# Dev links

http://docs.puppetlabs.com/puppet/2.7/reference/modules_publishing.html
