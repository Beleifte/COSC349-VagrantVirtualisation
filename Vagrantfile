# -*- mode: ruby -*-
# vi: set ft=ruby :

# A Vagrantfile to set up three VMs, a webserver and two database servers,
# connected together using an internal network with manually-assigned
# IP addresses for the VMs.

Vagrant.configure("2") do |config|
 
  config.vm.box = "ubuntu/focal64"
 

 # Defines the webserver VM, which I have named "webserver".

  config.vm.define "webserver" do |webserver|
    # These are options specific to the webserver VM
    webserver.vm.hostname = "webserver"

   #Our host computer can connect to IP address 127.0.0.1 port 8080, and that network
   # request will reach our webserver VM's port 80.

    webserver.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
    
    # We set up a private network that our VMs will use to communicate
    # with each other. 
    webserver.vm.network "private_network", ip: "192.168.56.11"

    # Necessary to build and run in the CS Labs
    webserver.vm.synced_folder ".", "/vagrant", owner: "vagrant", group: "vagrant", mount_options: ["dmode=775,fmode=777"]

    # Now we have a section specifying the shell commands to provision the webserver VM. 
    webserver.vm.provision "shell", path: "build-vms-scripts/build-webserver-vm.sh"
   
end

# Here is the section for defining the database server, which I have named "dbadmin".
config.vm.define "dbadmin" do |dbadmin|
  dbadmin.vm.hostname = "dbadmin"

  # Note that the IP address is different from that of the webserver
  dbadmin.vm.network "private_network", ip: "192.168.56.12"
  dbadmin.vm.synced_folder ".", "/vagrant", owner: "vagrant", group: "vagrant", mount_options: ["dmode=775,fmode=777"]

  # Now we have a section specifying the shell commands to provision the dbadmin VM.
  dbadmin.vm.provision "shell", path: "build-vms-scripts/build-dbadmin-vm.sh"

end

 # Here is the section for defining the database server, which I have named "dbserver".
config.vm.define "dbserver" do |dbserver|
  dbserver.vm.hostname = "dbserver"

  # Note that the IP address is different from that of the other VMs
  dbserver.vm.network "private_network", ip: "192.168.56.13"
  dbserver.vm.synced_folder ".", "/vagrant", owner: "vagrant", group: "vagrant", mount_options: ["dmode=775,fmode=777"]
  
  # Now we have a section specifying the shell commands to provision the dbserver VM.
  dbserver.vm.provision "shell", path: "build-vms-scripts/build-dbserver-vm.sh"  
  end 

end
