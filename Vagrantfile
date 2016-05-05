# -*- mode: ruby -*-

# vi: set ft=ruby :


balancer_nodes =  { 
"devops_tech_exercises" => { 
"web_nodes" => { 
  "web1" => { :ip => '192.168.50.4', :port => "18080" },
  }
  }
}


app_nodes =  { 
"devops_tech_exercises" => { 
"app_nodes" => { 
  "app1" => { :ip => '192.168.50.7', :port => "8484" },
  "app2" => { :ip => '192.168.50.8', :port => "8484" } 
  }
  }
}


Vagrant.configure("2") do |config|
  
  app_nodes['devops_tech_exercises']['app_nodes'].each do |name, vals|
  config.vm.define name do |config|
    config.vm.box = "ubuntu/trusty64"
    config.vm.hostname = name
    config.vm.network :private_network, ip: vals[:ip]
    config.vm.provision "chef_solo" do |chef|
      chef.add_recipe "app_cluster::application_node"
    end
  end
  end

  
  balancer_nodes['devops_tech_exercises']['web_nodes'].each do |name, vals|
  config.vm.define "web", primary: true do  |web|
    web.vm.box = "ubuntu/trusty64"
    web.vm.hostname = name
    web.vm.network "private_network", ip: vals[:ip]
    web.vm.network "forwarded_port", guest: 80, host: vals[:port]
    web.vm.provision "chef_solo" do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.add_recipe "app_cluster::nginx"
          chef.json = app_nodes
    end
  end
  end

end
