Configuration
=============

The configuration functions all take two arguments, ``$file`` and ``$config``

They all rely exclusively on ``augeas`` for configuration and thus, configuration
is done using ``augeas`` commands for maximum flexibility.

The ``puppet-php`` module includes a custom lens backported from the ``augeas``
project, so it can support all PHP ini and FPM pool configurations out of the box.

php::config
###########

The most basic configuration function in ``puppet-php``.

It's basically a wrapper for an ``augeas`` block, with the small twist that it
automatically uses the internal ``augeas`` lens for PHP and for faster modification
time.

.. note ::

  This function do not trigger any refresh of services out of the box

Example code, configuring PHP APC to be enabled and use more memory than default.

.. code-block:: puppet

  php::config { 'a-unique-name':
    file    => '/path/to/the/ini/f,ile'
    config  => [
      'set .anon/apc.enabled 1',
      'set .anon/apc.shm_size 64M'
    ]
  }

php::fpm::config
################

This function works exactly as ``php::config``, with the added benefit that any
modifications done through this function, ensures that PHP FPM is reloaded.

.. note ::

  The default value for ``$file`` in this function is the actual PHP FPM
  configuration file

php::apache::config
###################

This function works exactly as ``php::config``, with the added benefit that any
modifications done through this function, ensures that apache is reloaded.

.. note ::

  The default value for ``$file`` in this function is the actual PHP apache
  configuration file

php::cli::config
################

This function works exactly as ``php::config``, with no automatic service reloading.

It's left there mostly for completeness sake, and for more precise and easy manifest
authoring.

.. note ::

  The default value for ``$file`` in this function is the actual PHP CLI
  configuration file
