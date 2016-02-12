.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


**Recipe**

.. code-block:: ruby

   chef_gem 'default_action'
   
   chef_gem 'explicit_action' do
     action :install
   end
   
   chef_gem 'with_attributes' do
     version '1.0.0'
   end
   
   chef_gem 'specifying the identity attribute' do
     package_name 'identity_attribute'
   end

**Unit Test**

.. code-block:: ruby

   require 'chefspec'
  
   describe 'chef_gem::install' do
     let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }
   
     it 'installs a chef_gem with the default action' do
       expect(chef_run).to install_chef_gem('default_action')
       expect(chef_run).to_not install_chef_gem('not_default_action')
     end
   
     it 'installs a chef_gem with an explicit action' do
       expect(chef_run).to install_chef_gem('explicit_action')
     end
   
     it 'installs a chef_gem with attributes' do
       expect(chef_run).to install_chef_gem('with_attributes').with(version: '1.0.0')
       expect(chef_run).to_not install_chef_gem('with_attributes').with(version: '1.2.3')
     end
   
     it 'installs a chef_gem when specifying the identity attribute' do
       expect(chef_run).to install_chef_gem('identity_attribute')
     end
   end
