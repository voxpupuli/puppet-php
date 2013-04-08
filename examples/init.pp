include php

class {
  'php::pear':
    ensure => installed;
}
package { 'pear.phpunit.de/PHPUnit':
  ensure    => installed,
  provider  => pear;
}
