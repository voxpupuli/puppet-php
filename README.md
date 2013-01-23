puppet-php
==========

Puppet module to manage PHP on debian using dotdeb apt repository

Right now only supports dotdeb on debian squeeze, should be fairly easy to modify if needed though

Puppet forge URL: http://forge.puppetlabs.com/nodes/php

### Providers

The module provides a `pear` and `pecl` provider 

I've not coded them from scratch, but modified them heavily to make them more optimized and feature rich

Pear example: 

```
package { "pear.phpunit.de/PHPUnit":
  	ensure 		=> "3.7.12",
		provider	=> pear;
}
```

Pecl example:

```
package { "igbinary":
		ensure   => installed,
		provider => pecl;
}
```

### PHP SAPIs

By default the module comes with support for mod_php (`libapache2-mod-php5`) and cli `php5-cli`

### PHP modules

The following modules are supported by default:

* apc (with optinal configuration)
* curl
* gd
* gearman
* http
* igbinary
* imagick
* mcrypt
* mysql
* redis
* ssh2
* uploadprogress
* xdebug

each of them are located in the `php::pecl` namespace

### Packages

The following PHP related packages come build in too

* Composer
* phpunit
