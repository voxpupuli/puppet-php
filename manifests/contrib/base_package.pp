define php::contrib::base_package(
  $ensure,
  $provider
) {

	if !defined(Package['php5']) {
		package { 'php5':
			ensure 	 => $ensure,
			provider => $provider
		}
	}

}
