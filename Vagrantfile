# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# Configure the domain you'd like to use for your vm's.
domain = "hwx.test"

# Identify the vm's by name, ipaddress, cpu's, memory and the roles and additional recipes.
boxes = [
	{:name => "pm1", :ipaddress => "192.168.90.20", :cpus => 2, :memory => 2048, :roles => ["base", "ambari"], :recipes => []},
    {:name => "pm2", :ipaddress => "192.168.90.21", :cpus => 2, :memory => 2048, :roles => ["base"], :recipes => []},
    {:name => "pw1", :ipaddress => "192.168.90.22", :cpus => 2, :memory => 2048, :roles => ["base"], :recipes => []},
    {:name => "pw2", :ipaddress => "192.168.90.23", :cpus => 2, :memory => 2048, :roles => ["base"], :recipes => []},
    {:name => "pw3", :ipaddress => "192.168.90.24", :cpus => 2, :memory => 2048, :roles => ["base"], :recipes => []}
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Change to match your copy of the vagrant private ssh-key used by the box.  
  config.ssh.private_key_path = "/Users/%s/.ssh/vagrant" % ENV['USER'].to_s

  config.ssh.username = "vagrant"
  
  config.vm.provision :hostmanager
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true

  boxes.each do |opts|
    config.vm.define opts[:name] do |vmconfig|
      # CentOS 6.4 x86_64 Minimal (VirtualBox Guest Additions 4.2.12, Chef 11.4.4, Puppet 3.1.1)
      
      # To use the box, download it from the following URL:
      # http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20130427.box
      # Save it locally and add it to the vagrant application with:
      # vagrant box add "CentOS_64_x64" <location_of_the_local_box_file> --provider virtualbox
      vmconfig.vm.box = "CentOS_64_x64"

      vmconfig.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--cpus", opts[:cpus]]
        vb.customize ["modifyvm", :id, "--memory", opts[:memory]]
      end

	  # Using the above "domain" value to set the hostname.
      vmconfig.vm.hostname = "%s" % opts[:name]+"."+domain.to_s
      vmconfig.vm.network :private_network, ip: opts[:ipaddress]

      vmconfig.hostmanager.aliases = opts[:name]

      vmconfig.vm.provision :chef_solo do |chef|
        chef.cookbooks_path = ["cookbooks", "site-cookbooks"]
        chef.data_bags_path = "databags"
        chef.roles_path = "roles"
		
		
        opts[:roles].each do |role|
          chef.add_role(role)
        end

        opts[:recipes].each do |recipe|
          chef.add_recipe(recipe)
        end
        
        # Pass the domain to the recipes.
        chef.json = {
    		"default_attributes" => {
        		"hdp-prep" => {
            		"domain" => {
            			"name" => :domain
            		}
        		},
        		"activemq" => {
        			"wrapper" => {
        				"max_memory" => 1024
        			}
        		}
    		}
  		}
      end
    end
  end
end
