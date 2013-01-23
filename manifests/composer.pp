# == Class: php::composer
#
# Install composer package manager
#
# === Parameters
#
# No parameters
#
# === Variables
#
# No variables
#
# === Examples
#
#  include php::composer
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::composer {

	include php::composer::package

}
