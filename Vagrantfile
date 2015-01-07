# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.omnibus.chef_version = :latest
  
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.hostname = "172.17.8.5"

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "b9centos"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "https://github.com/beyond9/b9centos/releases/download/v7.0.0/centos7-20141106.box"

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  config.vm.network :private_network, ip: "172.17.8.5"

  # The path to the Berksfile to use with Vagrant Berkshelf
  # config.berkshelf.berksfile_path = "./Berksfile"

  # Enabling the Berkshelf plugin. To enable this globally, add this configuration
  # option to your ~/.vagrant.d/Vagrantfile file
  config.berkshelf.enabled = true

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to exclusively install and copy to Vagrant's shelf.
  # config.berkshelf.only = []

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to skip installing and copying to Vagrant's shelf.
  # config.berkshelf.except = []

  config.vm.provision :chef_solo do |chef|
    chef.json.merge!({
      :apache => {
        :sites_path           => "/var/www",
        :server_port          => "80",
        :listen_ports         => ["80", "443"]
      },
      :percona => {
        :env => 'dev'
      },
      :passwords => {
        :root_password => '',
        :myadmin_password => '',
        :debian_password => '',
        :server_repl_password => ''
      }
    })

    chef.add_recipe "b9apache::default"
    chef.add_recipe "b9apache::vagrant"
    chef.add_recipe "b9php::default"
    chef.add_recipe "b9php::pear"
    chef.add_recipe "b9php::oracle"
    chef.add_recipe "b9ruby::default"
    chef.add_recipe "b9mysql::default"
    chef.add_recipe "b9npm::default"
    chef.add_recipe "memcached"
    chef.add_recipe "sqlite"
    chef.add_recipe "sendmail"
    chef.add_recipe "b9base::default"
  end
end
