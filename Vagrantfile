# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |conf|
[1,2].each do |i|
conf.vm.define "#{i}elk" do |elk|
 	elk.vm.box = "sbeliakou/centos"
  	elk.vm.hostname = "#{i}elk"
  	elk.vm.box_check_update = false
  	elk.vm.network :private_network, ip: "192.168.19.#{i}0"
	#webs.vm.network "forwarded_port", guest: 8080, host: 1010
	elk.vm.provider "virtualbox" do |vb|

 # Customize the amount of memory on the VM:
	vb.name = "#{i}elk"
# vb.gui = true
	vb.memory = "2048"
	end
  elk.vm.provision "shell", path: "elk#{i}.sh"
	end
	end
	end
