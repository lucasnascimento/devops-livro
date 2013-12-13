Vagrant.configure("2") do |config|
  
  config.vm.box = "precise32"

  config.vm.define :db do |db_config|
    db_config.vm.network :private_network, :ip => "192.168.33.10"
    db_config.vm.provision "puppet" do |puppet|
      puppet.manifest_file = "db.pp"
    end
  end

  config.vm.define :web do |web_config|
    web_config.vm.network :private_network, :ip => "192.168.33.12"
    web_config.vm.provision "puppet" do |puppet|
      puppet.manifest_file = "web.pp"
    end
  end

  config.vm.define :monitor do |monitor_config|
    monitor_config.vm.network :private_network, :ip => "192.168.33.14"
#    monitor_config.vm.provision "puppet" do |puppet|
#      puppet.manifest_file = "monitor.pp" 
#    end
  end

end
