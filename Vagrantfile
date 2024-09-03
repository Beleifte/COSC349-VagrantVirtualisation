# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "ubuntu/focal64"
 


  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.define "webserver" do |webserver|
    webserver.vm.hostname = "webserver"
    webserver.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
    webserver.vm.network "private_network", ip: "192.168.2.11"



  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  config.vm.synced_folder ".", "/vagrant", owner: "vagrant", group: "vagrant", mount_options: ["dmode=775,fmode=777"]

  

     export MYSQL_PWD='insecure_mysqlroot_pw'
     echo "mysql-server mysql-server/root_password password $MYSQL_PWD" | debconf-set-selections 
     echo "mysql-server mysql-server/root_password_again password $MYSQL_PWD" | debconf-set-selections
     apt-get -y install mysql-server
     echo "CREATE DATABASE fvision;" | mysql
     echo "CREATE USER 'webuser'@'%' IDENTIFIED BY 'insecure_db_pw';" | mysql
     echo "GRANT ALL PRIVILEGES ON fvision.* TO 'webuser'@'%'" | mysql
 
     export MYSQL_PWD='insecure_db_pw'
     cat /vagrant/setup-database.sql | mysql -u webuser fvision
 

      # Change VM's webserver's configuration to use shared folder.
    # (Look inside test-website.conf for specifics.)
    cp /vagrant/website.conf /etc/apache2/sites-available/
    # install our website configuration and disable the default
    a2ensite website
    a2dissite 000-default
    service apache2 reload

   SHELL
end
