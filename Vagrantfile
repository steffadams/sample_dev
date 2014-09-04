Vagrant::Config.run do |config|
  config.vm.box = "hashicorp/precise64"
  # Port forward the apache web server
  config.vm.forward_port 80, 8080
  # Port forward the mysql server
  config.vm.forward_port 3306, 3307
  config.vm.provision :puppet
end
