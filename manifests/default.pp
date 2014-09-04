# ENSURE LATEST UPDATES APPLIED
exec { "apt-get update":
  command => "apt-get update -y --fix-missing",
  path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/usr/local/sbin:/sbin",
}
exec { "apt-get upgrade":
  command => "apt-get upgrade -y --fix-missing",
  path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/usr/local/sbin:/sbin",
  require => Exec["apt-get update"],
}

# INSTALL APACHE WEB SERVICE AND ENSURE RUNNING
package { "apache2":
  ensure  => present,
  require => Exec["apt-get upgrade"],
}
service { "apache2":
  ensure  => "running",	
  require => Package["apache2"],
}

# SET SITE LOCATION
file { "/var/www/webapp":
  ensure  => "link",
  target  => "/vagrant/sample-webapp",
  require => Package["apache2"],
  notify  => Service["apache2"],
}

# INSTALL MORE PACKAGES
package { ["python-pycurl", "python-software-properties", "unattended-upgrades"]: 
  ensure => present, 
  require => Exec["apt-get upgrade"],
}
package { ["vim","vim-addon-manager", "vim-puppet","php5","php5-cli","php5-mcrypt"]: 
  ensure => present,   
  require => Exec["apt-get upgrade"],
}
package { ["mysql-server","php5-mysql","unzip","curl","openssl"]:
  ensure => present,   
  require => Exec["apt-get upgrade"],
}

# DOWNLOAD COMPOSER
exec { "get_composer":
  command => "/usr/bin/curl -sS https://getcomposer.org/installer | php",
  unless  => "/usr/bin/test -f /usr/local/bin/composer",
  require => Package["php5-cli"], 
}

# INSTALL COMPOSER
exec {"install_composer":
  command => "/bin/mv /home/vagrant/composer.phar /usr/local/bin/composer",
  creates => "/usr/local/bin/composer",
	onlyif => "/usr/bin/test -f /home/vagrant/composer.phar",
	require => Exec["get_composer"],
}
