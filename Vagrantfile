# -*- mode: ruby -*-
# vi: set ft=ruby :

domain = 'artery'

Vagrant.configure("2") do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  ## For masterless, mount your salt file root
  config.vm.synced_folder "./", "/home/vagrant/production_current/"
  config.vm.synced_folder "provisioning/salt/roots/", "/srv/salt/"
  config.vm.synced_folder "provisioning/salt/pillar/", "/srv/pillar/"

  ## Use all the defaults:
  config.vm.provision :salt do |salt|

    # Configure the minion
    salt.minion_config = "provisioning/salt/minions/minion"

    # Webserver configuration
    config.vm.define "web", primary: true do |web|
      # Network
      web.vm.hostname = "web1.#{domain}"
      web.vm.network :private_network, ip: "172.16.0.10"

      # Configure the minion
      salt.minion_config = "provisioning/salt/minions/minion_web"

    end

    # Database configuration
    config.vm.define "db" do |db|
      # Network
      db.vm.hostname = "db1.#{domain}"
      db.vm.network :private_network, ip: "172.16.0.20"

      # Configure the minion
      salt.minion_config = "provisioning/salt/minions/minion_postgres"
    end

    # Varnish configuration
    config.vm.define "varnish" do |varnish|
      # Network
      varnish.vm.hostname = "varnish1.#{domain}"
      varnish.vm.network :private_network, ip: "172.16.0.30"

      # Configure the minion
      salt.minion_config = "provisioning/salt/minions/minion_varnish"
    end


    config.vm.provider :virtualbox do |vb|
       # Use VBoxManage to customize the VM. For example to change memory:
       vb.customize ["modifyvm", :id, "--memory", "1024"]
       vb.customize ["modifyvm", :id, "--cpus", "1"]
     end

    # Run the highstate on start
    salt.run_highstate = true

    # Show the output of salt
    salt.verbose = true

    # Install the latest version of SaltStack
    salt.install_type = "daily"

  end
end
