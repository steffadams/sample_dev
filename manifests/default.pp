# ENSURE LATEST UPDATES APPLIED
exec { "apt-get update":
  path => "/usr/bin",
}
# INSTALLL APACHE WEB SERVICE AND ENSURE RUNNING
package { "apache2":
  ensure  => present,
  require => Exec["apt-get update"],
}
service { "apache2":
  ensure  => "running",
  require => Package["apache2"],
}

# SET SITE LOCATION
file { "/var/www/sample-webapp":
  ensure  => "link",
  target  => "/vagrant/sample-webapp",
  require => Package["apache2"],
  notify  => Service["apache2"],
}

# REQUIRED PACKAGES
package { "python-software-properties": ensure => present, }
package { ["vim","vim-addon-manager", "vim-puppet"]: ensure => present, }
package { ["php5","php5-cli","php5-mcrypt"]: ensure => present, }
package { ["mysql-server","php5-mysql"]: ensure => present, }
package { ["unzip","curl","openssl"]: ensure => present, }

# DOWNLOAD COMPOSER
exec { "get_composer":
    command => "/usr/bin/curl -sS https://getcomposer.org/installer | php",
    unless  => "/usr/bin/test -f /usr/local/bin/composer",
    require => Package["php5-cli"], 
}

# INSTALL COMPOSER
exec {"install_composer":
    command => "/bin/mv /home/vagrant/composer.phar /usr/local/bin/composer",
    onlyif  => "/usr/bin/test -f /home/vagrant/composer.phar",
}
