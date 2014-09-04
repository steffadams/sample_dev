# sample_dev

#####A basic laravel webdev environment provisioned by puppet using a vagrant/vbox ubuntu install
Install and provision the vm with command:

`vagrant up`

#####TODO: PUPPETIZE THE REMAINING BELOW STEPS

To install laravel once provisioned do:

`vagrant ssh`

Upgrade to the latest php version
```
sudo add-apt-repository ppa:ondrej/php5-oldstable
sudo apt-getupdate
sudo apt-get install -y php5
```

Install rewrite apache2 module
```
sudo a2enmod rewrite
sudo service apache2 restart
```

**Note for Windows Hosts Only:** - Define linux vim terminal within bashrc

`echo "export TERM=linux vim" >> ~/.bashrc`

Within /etc/apache2/sites-available/default at DocumentRoot section (twice) set:

`AllowOverride All`

Within /etc/apache2/sites-available/default at DocumentRoot section, set DocumentRoot (twice) to path:

`/var/www/webapp/public`

Within /etc/apache2/envvars set:

```
APACHE_RUN_USER=vagrant
APACHE_RUN_GROUP=vagrant
```

Restart apache2 service

```
sudo service apache2 stop
sudo rm -r /var/lock/apache2
sudo service apache2 start
```

Install Laravel
```
cd /var/www/webapp
wget https://github.com/laravel/laravel/archive/master.zip
sudo unzip master.zip && cd laravel-master && sudo mv * ../ && cd ..
rm -r laravel-master && rm master.zip
sudo composer install
sudo chmod -R 777 app/storage
```
Resart Apache

`sudo service apache2 restart`

Navigate within browser to:

`http://localhost:8080`

