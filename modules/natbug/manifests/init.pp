class natbug {
    $bind_package = $::operatingsystem ? {
        "centos"    => "bind-utils",
        "ubuntu"    => "bind9utils",
    }

    package { "$bind_package": }
    file { "/usr/local/bin/natbug_dig.sh":
        mode    => 755,
        source  => "puppet:///modules/natbug/natbug_dig.sh",
    }
}
