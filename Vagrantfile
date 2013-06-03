#!/usr/bin/env ruby

box = ENV['VAGRANT_BOX'] || "opscode_ubuntu-12.04_chef-11.2.0"

Vagrant.configure('2') do |config|

  config.vm.hostname       = 'wal-e'
  config.vm.box            = box
  config.vm.box_url        = "https://opscode-vm.s3.amazonaws.com/vagrant/#{box}.box"
  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    chef.run_list = [
      'recipe[wal-e::cron]'
    ]
  end
end

