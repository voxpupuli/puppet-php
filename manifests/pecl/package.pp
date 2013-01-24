define php::pecl::package {
  include php::params

  $mod = $name
  $extensions = $php::params::extensions
  $extension = $extensions[$mod]

  $package_name = $extension['package']
  $provider_name = $extension['provider']

  package { $package_name:
    ensure   => $php::params::php_version,
    provider => $provider_name;
  }

  if $extension['require'] {
    $extension['require'] -> Package[$package_name]
  }

  if $extension['notify'] {
    Package[$package_name] ~> $extension['notify']
  }
}
