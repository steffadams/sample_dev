Vagrant::Config.run do |config|
  config.vm.box = "hashicorp/precise64"
  config.vm.forward_port 80, 8080
  config.vm.provision :puppet
end
