# sample_dev

# A basic laravel webdev environment provisioned by puppet using vagrant/vbox ubuntu vm

# TODO: PUPPETIZE THE REMAINING BELOW STEPS: 
# To install laravel once provisioned do:

vagrant ssh

# Upgrade to the latest php version
sudo add-apt-repository ppa:ondrej/php5-oldstable
sudo apt-get install php

# Install rewrite apache2 module
sudo a2enmod rewrite
sudo service apache2 restart

# Set AllowOverride All within (default is AllowOverride None)
/etc/apache2/sites-available/default

# Set Document root wthin apache2 to be
/var/www/sample-webapp/public

# Install Laravel
cd /var/www/sample-webapp
wget https://github.com/laravel/laravel/archive/master.zip
sudo unzip master.zip && cd laravel-master/ && sudo mv * ../ && cd ..
rm -r laravel-master && rm master.zip
sudo composer install
sudo chmod -R 777 app/storage

# Resart Apache
sudo service apache2 restart

# Navigate within browser to:
http://localhost

