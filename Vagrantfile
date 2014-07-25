# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'yaml'

#
# Vagrant configuration for vagrant-jdev-box
# @link
# https://github.com/rob-murray/vagrant-javadev-box
#
Vagrant.configure("2") do |config|
  config.vm.define "scarebox" do |scarebox|

    settings = {
      'src_folder' => "../../src/scarecrow",
      'hostname' => "scarebox.nanigans.com",
    }

    custom_settings = File.exists?('settings.yml') ? YAML.load_file('settings.yml') : {}

    settings.merge!(custom_settings)

    scarebox.vm.box = "precise64"

    # Grab this via `vagrant box add precise64 http://files.vagrantup.com/precise64.box`
    scarebox.vm.box_url = "http://files.vagrantup.com/precise64.box"

    scarebox.ssh.forward_agent = true
    scarebox.vm.network "private_network", ip: "192.168.56.103"
    scarebox.vm.hostname = settings['hostname']

    # Forward ports
    scarebox.vm.network :forwarded_port, guest: 8080,    host: 8080    # Java app server; jetty

    # Share the working dir - host, guest
    scarebox.vm.synced_folder "scripts", "/vagrant/scripts"
    scarebox.vm.synced_folder settings['src_folder'], "/vagrant/scarecrow"

    scarebox.vm.provision "shell", inline: "apt-get update --fix-missing"

    scarebox.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", "2048"]
    end

    scarebox.vm.provision :puppet do |puppet|
       puppet.manifests_path = "puppet/manifests"
       puppet.manifest_file  = "base.pp"
       puppet.module_path = "puppet/modules"
       puppet.options = "--verbose"
    end

    scarebox.vm.provision :shell, :inline => "mkdir -p /var/log/nanigans"
    scarebox.vm.provision :shell, :inline => "mkdir -p /vagrant/scarecrow/target"
    scarebox.vm.provision :shell, :inline => "mkdir -p /var/run/javapa"
    scarebox.vm.provision :shell, :inline => "chmod 777 /var/log/nanigans"
  end
end
