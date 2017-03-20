Vagrant.configure("2") do |config|

  # our box
  # grab a xenial64, 16.04 LTS, box for OpenJDK 8
  config.vm.box = "ubuntu/xenial64"
  # a name
  config.vm.hostname = "testing-repox"

  # networking
  # tomcat
  config.vm.network :forwarded_port, guest: 8080, host: 8080, auto_correct:true
  # mysql
  config.vm.network :forwarded_port, guest: 3306, host: 3306, auto_correct: true
end


