class php::cli::config {

    augeas { "Tweak cli php.ini settings":
        context => "/files/etc/php5/cli/php.ini",
        changes => [
            "set 'PHP/short_open_tag' 'Off",
            "set 'PHP/asp_tags' 'Off",
            "set 'PHP/expose_php' 'Off",
            "set 'PHP/memory_limit' '1G",
            "set 'PHP/display_errors' 'On",
            "set 'PHP/log_errors' 'On",
            "set 'PHP/post_max_size' '100M",
            "set 'PHP/max_execution_time' '600'",
            "set 'PHP/upload_max_filesize' '100M'",
            "set 'PHP/allow_url_include' 'Off'",
            "set 'PHP/error_log' 'syslog'",
            "set 'Date/date.timezone' 'UTC'",
        ],
        require => Package["php5-cli"];
    }

}
