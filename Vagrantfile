Vagrant::Config.run do |config|
    config.vm.define :centos_intel do |c|
        c.vm.box = "centos61-puppet26"
        provision(c)
    end
    config.vm.define :centos_amd do |c|
        c.vm.box = "centos61-puppet26"
        provision(c)
        c.vm.customize(["modifyvm", :id, "--nictype1", "Am79C973"])
    end
    config.vm.define :ubuntu_intel do |c|
        c.vm.box = "lucid64"
        provision(c)
    end
    config.vm.define :ubuntu_amd do |c|
        c.vm.box = "lucid64"
        provision(c)
        c.vm.customize(["modifyvm", :id, "--nictype1", "Am79C973"])
    end
end

def provision(config)
    config.vm.provision :puppet do |puppet|
        puppet.manifest_file  = "site.pp"
        puppet.manifests_path = "manifests"
        puppet.module_path = "modules"
    end
    config.vm.provision :shell do |shell|
        shell.inline = "/usr/local/bin/natbug_dig.sh $1"
        shell.args = "github.com"
    end
end
