define php::pecl::config {

  include php::params

  $extension        = $name
  $extensions       = $php::params::extensions
  $extension_config = $extensions[$extension]
  $config_file      = $extension_config['config_file']
  $config_changes   = $extension_config['config_changes']

# http://projects.puppetlabs.com/projects/puppet/wiki/Puppet_Augeas#Templating+complex+changes/commands
# http://open.spotify.com/track/7CA9quGbiLIowg3F96CgX7

  augeas { "php-pecl-${extension}-config":
    context => "/files${config_file}",
    changes => template('php/augeas_commands.erb')
  }

}
