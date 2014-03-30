Installation
============

Installing composer is quick and simple.

Requirements
------------

* Debian / Ubuntu
* puppet 3.2+

puppet module
-------------

.. code-block:: sh

  puppet module install nodes/php

Using git submodule
-------------------

.. code-block:: sh

  git submodule add git@github.com:jippi/puppet-php.git modules/php

Class dependencies
------------------

Most of the inter-class dependencies is already taken care of internally in the
plugin, though the configuration below is recommended to force the correct flow
of installation, configuration and services

.. code-block:: puppet

  # Install extensions
  Php::Extension <| |>
    # Configure extensions
    -> Php::Config <| |>
    # Reload webserver
    ~> Service["apache2"]


.. note ::

  The module will automatically detect if you use ``FPM`` and reload it when
  relevant PHP configuration has changed
