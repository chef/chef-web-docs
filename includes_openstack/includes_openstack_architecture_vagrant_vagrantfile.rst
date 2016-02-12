.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 

|vagrant| uses a **Vagrantfile** for managing its configuration. Within the |openstack chef_repo| there is a Vagrantfile that configures the |virtualbox| virtual machine for our purposes. A few parts of that file are listed here:

.. code-block:: ruby

   Vagrant.require_plugin 'vagrant-berkshelf'
   Vagrant.require_plugin 'vagrant-chef-zero'
   Vagrant.require_plugin 'vagrant-omnibus'

   Vagrant.configure('2') do |config|
     # Berkshelf plugin configuration
     config.berkshelf.enabled = true

     # Chef-Zero plugin configuration
     config.chef_zero.enabled = true
     config.chef_zero.chef_repo_path = '.'

     # Omnibus plugin configuration
     config.omnibus.chef_version = :latest

This is enabling and configuring the use of the |berkshelf|, |chef zero| and |omnibus installer| plugins for |vagrant|.

.. code-block:: ruby

     # Port forwarding rules, for access to openstack services
     config.vm.network 'forwarded_port', guest: 443, host: 8443     # dashboard-ssl
     config.vm.network 'forwarded_port', guest: 4000, host: 4000    # chef-zero
     config.vm.network 'forwarded_port', guest: 8773, host: 8773    # compute-ec2-api
     config.vm.network 'forwarded_port', guest: 8774, host: 8774    # compute-api

This forwards ports from the |vagrant| virtual machine for accessing the |openstack| dashboard and APIs. You may also access the |chef zero| installation with a custom |knife rb| configuration file.

.. code-block:: ruby

     # OpenStack-related settings
     config.vm.network 'private_network', ip: '33.33.33.60'
     config.vm.network 'private_network', ip: '192.168.100.60'
     config.vm.provider 'virtualbox' do |vb|
       vb.customize ['modifyvm', :id, '--cpus', 2]
       vb.customize ['modifyvm', :id, '--memory', 2048]
       vb.customize ['modifyvm', :id, '--nicpromisc2', 'allow-all']
       vb.customize ['modifyvm', :id, '--nicpromisc3', 'allow-all']
     end

This creates additional network cards and networks for the |vagrant| virtual machine and increases the available memory and CPUs.

.. code-block:: ruby

     chef_environment = 'vagrant'
     chef_run_list = [ 'role[allinone-compute]' ]

     # Ubuntu 12.04 Config
     config.vm.define :ubuntu1204 do |ubuntu1204|
       ubuntu1204.vm.hostname = 'ubuntu1204'
       ubuntu1204.vm.box = 'opscode-ubuntu-12.04'
       ubuntu1204.vm.box_url = 'https://opscode-vm-bento.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_provisionerless.box'
       ubuntu1204.vm.provision :chef_client do |chef|
         chef.environment = chef_environment
         chef.run_list = chef_run_list.unshift('recipe[apt::cacher-client]')
       end
     end
   end

|vagrant| is configured to use the chef_client provisioner with the ``vagrant`` environment and the ``allinone-compute`` role for the ``run_list``. The |virtualbox| images used are provided by the Bento project (https://github.com/chef/bento).
