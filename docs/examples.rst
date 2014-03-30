Examples
========

Generic / CLI
-------------

.. code-block:: puppet

  class roles::php($version = 'installed') {

    include php
    include php::apt
    include php::params
    include php::pear
    include php::composer
    include php::composer::auto_update

    # Extensions must be installed before they are configured
    Php::Extension <| |> -> Php::Config <| |>

    # Ensure base packages is installed in the correct order
    # and before any php extensions
    Package['php5-common']
      -> Package['php5-dev']
      -> Package['php5-cli']
      -> Php::Extension <| |>

    class {
      # Base packages
      [ 'php::dev', 'php::cli' ]:
        ensure => $version;

      # PHP extensions
      [
        'php::extension::curl', 'php::extension::gd', 'php::extension::imagick',
        'php::extension::mcrypt', 'php::extension::mysql', 'php::extension::ssh2',
        'php::extension::redis', 'php::extension::http', 'php::extension::opcache'
      ]:
        ensure => $version;

      [ 'php::extension::igbinary' ]:
        ensure => installed
    }

    # Install APC user cache only (php 5.5 uses OptCache instead of APC)
    php::extension { 'php5-apcu':
      ensure    => $version,
      package   => 'php5-apcu',
      provider  => 'apt'
    }

    # Install the INTL extension
    php::extension { 'php5-intl':
      ensure    => $version,
      package   => 'php5-intl',
      provider  => 'apt'
    }

    create_resources('php::config', hiera_hash('php_config', {}))
    create_resources('php::cli::config', hiera_hash('php_cli_config', {}))

  }


FPM
---

.. code-block:: puppet

  class roles::php_fpm($version = 'installed') {

    include php
    include php::apt
    include php::params

    class { 'php::fpm':
      ensure => $version
    }

    create_resources('php::fpm::pool',  hiera_hash('php_fpm_pool', {}))
    create_resources('php::fpm::config',  hiera_hash('php_fpm_config', []))

    Php::Extension <| |> ~> Service['php5-fpm']

    exec { "restart-php5-fpm":
      command  => "service php5-fpm restart",
      schedule => hourly
    }

  }
