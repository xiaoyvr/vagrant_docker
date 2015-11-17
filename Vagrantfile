# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

#required_plugins = %w('vagrant-vbguest')
#required_plugins.each do |plugin|
#   puts Vagrant.has_plugin?()pluginA
#   system "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
#end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
#  config.vm.box = "https://github.com/2creatives/vagrant-centos/releases/download/v6.4.2/centos64-x86_64-20140116.box"
   config.vm.box = "https://github.com/CommanderK5/packer-centos-template/releases/download/0.7.1/vagrant-centos-7.1.box"
#  config.trigger.after [:halt, :destroy] do
#          system("sudo pfctl -f /etc/pf.conf > /dev/null 2>&1; echo '==> Removing Port Forwarding'")
#  end
#
#  config.trigger.after [:provision, :up, :reload] do
#            system('echo "
#        rdr pass on lo0 inet proto tcp from any to 127.0.0.1 port 80 -> 127.0.0.1 port 80
#        rdr pass on lo0 inet proto tcp from any to 127.0.0.1 port 443 -> 127.0.0.1 port 443
#        " | sudo pfctl -f - > /dev/null 2>&1; echo "==> Fowarding Ports: 80 -> 8080, 443 -> 8443"')
#  end
  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", "5120"]
    v.customize ["modifyvm", :id, "--cpus", "5"]
    v.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
  end

  config.vm.define :local do |local|
	#local.vm.network "public_network", bridge: 'en0: Wi-Fi (AirPort)'
    local.vm.network "private_network", ip: "192.168.50.4"
    local.vm.network "forwarded_port", host: 3306, guest: 3306
    local.vm.network "forwarded_port", host: 8800, guest: 8800
    local.vm.network "forwarded_port", host: 10000, guest: 80
    local.vm.network "forwarded_port", host: 10001, guest: 81
    local.vm.network "forwarded_port", host: 3334, guest: 3334
    local.vm.network "forwarded_port", host: 6379, guest: 6379
    local.vm.network "forwarded_port", host: 63791, guest: 63791
    local.vm.network "forwarded_port", host: 26379, guest: 26379
    local.vm.synced_folder "./config", "/var/docker/config"
  end

  config.vm.provision "shell" do |s|
    s.path = "provision.sh"
  end 
end
