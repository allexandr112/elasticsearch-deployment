# -*- mode: ruby -*-
# vi: set ft=ruby :

datanodes_num = 2
masternodes_num = 2

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com. 

  config.hostmanager.enabled = true
  config.hostmanager.include_offline = true
  config.hostmanager.manage_host = false

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  (1..datanodes_num).each do |vmNumber|
    config.vm.define "datanode-#{vmNumber}" do |machine|
      machine.vm.box = "ubuntu/trusty64"
      machine.vm.hostname = "datanode-#{vmNumber}"
      machine.vm.network "private_network", ip: "192.168.77.#{vmNumber + 1}"
      # machine.vm.network "forwarded_port", guest: 9200, host: 9199+vmNumber 

      machine.vm.provider "virtualbox" do |vb| 
        vb.memory = 2048
        vb.cpus = 2
      end

      machine.ssh.insert_key = false
      config.ssh.keys_only = false
      machine.ssh.private_key_path = [ "./access.pem", "/home/las/.vagrant.d/insecure_private_key" ]
      machine.vm.provision "file", source: "access.pem.pub", destination: "~/.ssh/authorized_keys"
      machine.vm.provision "shell", inline: <<-EOF
        sudo sed -i -e "\\#PasswordAuthentication yes# s#PasswordAuthentication yes#PasswordAuthentication no#g" /etc/ssh/sshd_config
        sudo service ssh restart
      EOF
    end
  end

  (1..masternodes_num).each do |vmNumber|
    config.vm.define "masternode-#{vmNumber}" do |machine|
      machine.vm.box = "ubuntu/trusty64"
      machine.vm.hostname = "masternode-#{vmNumber}"
      machine.vm.network "private_network", ip: "192.168.77.#{vmNumber+datanodes_num+1}"
      # machine.vm.network "forwarded_port", guest: 9200, host: 9199+vmNumber  

      machine.vm.provider "virtualbox" do |vb| 
        vb.memory = 2048
        vb.cpus = 2
      end

      machine.ssh.insert_key = false
      config.ssh.keys_only = false
      machine.ssh.private_key_path = [ "./access.pem", "/home/las/.vagrant.d/insecure_private_key" ]
      machine.vm.provision "file", source: "access.pem.pub", destination: "~/.ssh/authorized_keys"
      machine.vm.provision "shell", inline: <<-EOF
        sudo sed -i -e "\\#PasswordAuthentication yes# s#PasswordAuthentication yes#PasswordAuthentication no#g" /etc/ssh/sshd_config
        sudo service ssh restart
      EOF
    end
  end

  config.vm.define "kibana" do |machine|
      machine.vm.box = "ubuntu/trusty64"
      machine.vm.hostname = "kibana"
      machine.vm.network "private_network", ip: "192.168.77.#{datanodes_num + masternodes_num + 2}"
      machine.vm.network "forwarded_port", guest: 5601, host: 5601

      machine.vm.provider "virtualbox" do |vb| 
        vb.memory = 1536
        vb.cpus = 2
      end

      machine.ssh.insert_key = false
      config.ssh.keys_only = false
      machine.ssh.private_key_path = [ "./access.pem", "/home/las/.vagrant.d/insecure_private_key" ]
      machine.vm.provision "file", source: "access.pem.pub", destination: "~/.ssh/authorized_keys"
      machine.vm.provision "shell", inline: <<-EOF
        sudo sed -i -e "\\#PasswordAuthentication yes# s#PasswordAuthentication yes#PasswordAuthentication no#g" /etc/ssh/sshd_config
        sudo service ssh restart
      EOF
    end

end
