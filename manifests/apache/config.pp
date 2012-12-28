class php::apache::config {

	augeas {
		"Tweak apache2 php.ini settings":
	        context => "/files/etc/php5/apache2/php.ini",
	        changes => [
	            "set 'PHP/short_open_tag' 'Off",
	            "set 'PHP/asp_tags' 'Off",
	            "set 'PHP/expose_php' 'Off",
	            "set 'PHP/memory_limit' '256M",
	            "set 'PHP/display_errors' 'Off",
	            "set 'PHP/log_errors' 'On",
	            "set 'PHP/post_max_size' '500M",
	            "set 'PHP/max_execution_time' '600'",
	            "set 'PHP/upload_max_filesize' '500M'",
	            "set 'PHP/allow_url_include' 'Off'",
	            "set 'PHP/error_log' 'syslog'",
				"set 'PHP/output_buffering' '4096'",
				"set 'PHP/output_handler' 'Off'",
	            "set 'Date/date.timezone' 'UTC'",
	        ];
	    }

	   Augeas["Tweak apache2 php.ini settings"] -> Package["libapache2-mod-php5"]
	   Augeas["Tweak apache2 php.ini settings"] ~> Service["apache2"]

}
