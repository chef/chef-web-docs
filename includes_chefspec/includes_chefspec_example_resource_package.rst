.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


**Recipe**

.. code-block:: ruby

   package 'explicit_action' do
     action :remove
   end
   
   package 'with_attributes' do
     version '1.0.0'
     action :remove
   end
   
   package 'specifying the identity attribute' do
     package_name 'identity_attribute'
     action :remove
   end

**Unit Test**

.. code-block:: ruby

   require 'chefspec'
   
   describe 'package::remove' do
     let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }
   
     it 'removes a package with an explicit action' do
       expect(chef_run).to remove_package('explicit_action')
       expect(chef_run).to_not remove_package('not_explicit_action')
     end
   
     it 'removes a package with attributes' do
       expect(chef_run).to remove_package('with_attributes').with(version: '1.0.0')
       expect(chef_run).to_not remove_package('with_attributes').with(version: '1.2.3')
     end
   
     it 'removes a package when specifying the identity attribute' do
       expect(chef_run).to remove_package('identity_attribute')
     end
   end
