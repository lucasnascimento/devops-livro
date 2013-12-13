exec { "apt-update":
	command => "/usr/bin/apt-get update"
}
file { "/etc/apt/preferences.d/nagios":
	owner   => root,
	group   => root,
	mode    => 0644,
	content => template("/tmp/vagrant-puppet/manifests/nagios"),
	notify  => Exec["apt-update"],
}

file { "/etc/apt/sources.list.d/raring.list":
	owner   => root,
	group   => root,
	mode    => 0644,
	content => template("/tmp/vagrant-puppet/manifests/raring.list"),
	notify  => Exec["apt-update"],
}
package { ["postfix","nagios3"]:
	ensure  => installed,
	require => Exec["apt-update"],
}
file { "/etc/nagios3/conf.d/loja_virtual.cfg":
	owner   => root,
	group   => root,
	mode    => 0644,
	content => template("/tmp/vagrant-puppet/manifests/loja_virtual.cfg"),
	require => Package["nagios3"],
	notify  => Service["nagios3"],

}
service { "nagios3":
	ensure     => running,
	enable     => true,
	hasstatus  => true,
	hasrestart => true,
	require    => Package["nagios3"],
}

$myorigin = "monitor.lojavirtualdevops.com.br"
$relayhost = "isp.lojavirtualdevops.com.br"

service { "postfix":
  ensure => running,
  enable => true,
}

file { "/etc/postfix/main.cf":
  ensure  => present,
  content => template("/tmp/vagrant-puppet/manifests/main.cf"),
  require => Package["postfix"],
  notify  => Service["postfix"],
}