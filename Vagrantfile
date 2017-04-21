Vagrant.configure("2") do |config|

  # our box
  # grab a xenial64, 16.04 LTS, box for OpenJDK 8
  config.vm.box = "geerlingguy/ubuntu1604"
  # a name
  config.vm.hostname = "testing-repox"

  # shared directory
  shared_dir = "/vagrant"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "3000"]
    vb.customize ["modifyvm", :id, "--cpus", "2"]
  end

  # networking
  # tomcat
  config.vm.network :forwarded_port, guest: 8080, host: 8080, auto_correct:true
  # mysql
  config.vm.network :forwarded_port, guest: 3306, host: 3306, auto_correct: true

  # shell scripts for configuring the box
  config.vm.provision :shell, path: "./scripts/add-packages.sh", :args => shared_dir, :privileged => false
  config.vm.provision :shell, path: "./scripts/build-repox.sh", :args => shared_dir, :privileged => false
  config.vm.provision :shell, path: "./scripts/python.sh", :args => shared_dir, :privileged => false
end


