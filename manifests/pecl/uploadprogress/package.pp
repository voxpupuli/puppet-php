class php::pecl::uploadprogress::package {

	package {
		"uploadprogress":
			ensure 	 => installed,
			provider => pecl;
	}

	Apt::Source["dotdeb"] -> Exec["apt_update"] -> Package["uploadprogress"]

}
