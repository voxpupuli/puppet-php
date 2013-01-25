define php::contrib::base_package(
  $version,
  $provider
) {

	if !defined(Package['php5']) {
		package { 'php5':
			ensure 	 => $version,
			provider => $provider
		}
	}

}
