+++
date = "2015-12-09T18:58:23+01:00"
draft = false
tags = ["Ansible", "Vagrant", "DevOps", "Rails", "Provisioning"]
title = "Setup a production Rails server with Ansible and Vagrant"

+++

I'm working on a rails project and want to automate server creation. There are several provisioning tools for such a task. I've chosen [Ansible](https://github.com/ansible/ansible) because of mostly good feedback.  

Because a search only results in a lot of pre-made Ansible setups which are confusing to newcomers I've decided to create a guide on how to create your own one with [Vagrant](http://www.vagrantup.com), Ansible, rvm, PostgreSQL, git running on Digital Ocean and locally.

Let's begin.<!--more-->

### What we'll configure

It's good to have a goal. We want to create a local production-like/staging VM environment and a real live production server running on [Digital Ocean](https://www.digitalocean.com/?refcode=9ddfa149e776). The steps we'll take:

- Create a Vagrant file with a local VM provider and a Digital Ocean provider (Ubuntu - 14.04 Trusty Tahr - 64bit)
- Harden the security of our sever
- Use nginx as web server
- Phusion Passenger as app server
- rvm with a specific rails version
- PostgreSQL for DB
- Git so we can push new app versions to the server and restart

This guide assumes that you already have Vagrant and Ansible installed on your machine and know the basics about Vagrant. 

### Creating the Vagrant file

Go to the root of your rails project and init Vagrant like this.
    
    $ cd project_root
    $ vagrant init

This will create a file called Vagrant. You can read through the content of it but we'll replace everything inside the *"Vagrant.configure(2) do |config|"* block.

I won't go too much into Vagrant because the meat of this tutorial is about Ansible. If you wish to learn more about Vagrant check out the [official document](https://docs.vagrantup.com/v2/).

#### VirtualBox Provider

First we'll define a hostname and our VirtualBox provider. The VM will have private network, 1GB of RAM and the ports 80 and 443 forwarded locally. This way we can test our rails app by simply visiting http://localhost:8080 (or :8443) in our browser.

    # -*- mode: ruby -*-
    # vi: set ft=ruby :
    
    # Defines our Vagrant environment
    
    Vagrant.configure("2") do |config|
    
      config.vm.hostname = "YOURHOSTNAME"
    
      # VirtualBox provider
      config.vm.provider :virtualbox do |vb, override|
    
        config.vm.box = "ubuntu/trusty64"
    
        override.vm.network :private_network, ip: "10.0.15.10"
        override.vm.network "forwarded_port", guest: 80, host: 8080, protocol: 'tcp'
        override.vm.network "forwarded_port", guest: 443, host: 8443, protocol: 'tcp'
    
        vb.memory = "1024"    # 1GB of RAM for our VM
      end
    end

If you were to run *vagrant up* right now it would create a VM running Ubuntu Trusty-64bit and the provided **hostname** to which you could connect using *vagrant ssh* (or ssh vagrant@10.0.15.10 with 'vagrant' as password)

#### Digital Ocean Provider
In order for this provider to work you need to have the [vagrant-digitalocean](https://github.com/smdahlen/vagrant-digitalocean/) plugin installed and a valid DO-token. Please see the link for how to get the token and which settings are available for the box.  

Add this right under the VirtualBox-block just befor the last *end*.

    # DigitalOcean provider
    config.vm.provider :digital_ocean do |ocean, override|
    
      override.vm.box = 'digital_ocean'
      override.vm.box_url = "https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box"
    
      override.ssh.private_key_path = '~/.ssh/id_rsa'
      override.ssh.username = 'USERNAME'	# default is 'vagrant', which is fine. 
      										# This setting only changes the DO user.
      										# VirtualBox username remains 'vagrant' 
      										# The user will be a sudo user.
    
      ocean.token=ENV['DO_AUTH_TOKEN'] 	# using an ENVIRONMENT var 
      ocean.image = 'ubuntu-15-04-x64'	# ubuntu trusty64 same as Virtual Box
      ocean.region = 'fra1'				# use the Frankfurt 1 location
      ocean.size = '512mb'				# with 512mb (smallest) size
    
    end

I've provided DO with my ssh-key which is saved locally on my computer under ~/.ssh/id_rsa. The provider will create a Digital Ocean droplet with the **hostname**-name specified on top and a new user-account specified at **config.ssh.username**. 

My DO_AUTH_TOKEN is saved in an ENVIRONMENT-variable declared in ~/.profile. If you're using source-control and plan to publish the repo do not place your TOKEN inside the Vagrantfile as it'll be visible for anyone to see and steal.

Running 

    vagrant up 

will use the virtualbox-provider by default. If you want to test your Digital Ocean configuration you need to append "\--provider digital_ocean". Doing so will create a droplet on your account. You will be charged money for this. 
  
    vagrant up --provider digital_ocean
 
 Once the doplet has been created you can connect to it the same way as you did with the VirtualBox provider

    vagrant ssh

If you open your Digtial Ocean dashboard you'll see the droplet. You can destroy it right there or by running 

    vagrant destroy


That is it for Vagrant. We can now either launch a local VM with vagrant up or a real droplet by adding the digital_ocean provider.

Once we have provisioning playbook for Ansible we'll revisit the Vagrantfile one last time. For now here is the full contents of the file up to now.

##### Vagrantfile: (so far)
    # -*- mode: ruby -*-
    # vi: set ft=ruby :
    
    # Defines our Vagrant environment
    
    Vagrant.configure("2") do |config|
    
      config.vm.hostname = "YOURHOSTNAME"	# Define your hostname
    
      # VirtualBox provider
      config.vm.provider :virtualbox do |vb, override|
    
        config.vm.box = "ubuntu/trusty64"
    
        override.vm.network :private_network, ip: "10.0.15.10"
        override.vm.network "forwarded_port", guest: 80, host: 8080, protocol: 'tcp'
        override.vm.network "forwarded_port", guest: 443, host: 8443, protocol: 'tcp'
    
        vb.memory = "1024"    # 1GB of RAM for our VM
      end
    
      # DigitalOcean provider
      config.vm.provider :digital_ocean do |ocean, override|
    
        override.vm.box = 'digital_ocean'
        override.vm.box_url = "https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box"
    
        override.ssh.private_key_path = '~/.ssh/id_rsa'
        override.ssh.username = 'USERNAME'	# Define username or 'vagrant' for default
    
        ocean.token=ENV['DO_AUTH_TOKEN'] 	# Make sure this ENV key exists on your machine
        ocean.image = 'ubuntu-15-04-x64'
        ocean.region = 'fra1'
        ocean.size = '512mb'
    
      end
    end

