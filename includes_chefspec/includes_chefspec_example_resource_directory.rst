.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


**Recipe**

.. code-block:: ruby

   directory '/tmp/default_action'
   
   directory '/tmp/explicit_action' do
     action :create
   end
   
   directory '/tmp/with_attributes' do
     user 'user'
     group 'group'
   end
   
   directory 'specifying the identity attribute' do
     path '/tmp/identity_attribute'
   end

**Unit Test**

.. code-block:: ruby

   require 'chefspec'
   
   describe 'directory::create' do
     let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }
   
     it 'creates a directory with the default action' do
       expect(chef_run).to create_directory('/tmp/default_action')
       expect(chef_run).to_not create_directory('/tmp/not_default_action')
     end
   
     it 'creates a directory with an explicit action' do
       expect(chef_run).to create_directory('/tmp/explicit_action')
     end
   
     it 'creates a directory with attributes' do
       expect(chef_run).to create_directory('/tmp/with_attributes').with(
         user: 'user',
         group: 'group',
       )
   
       expect(chef_run).to_not create_directory('/tmp/with_attributes').with(
         user: 'bacon',
         group: 'fat',
       )
     end
   
     it 'creates a directory when specifying the identity attribute' do
       expect(chef_run).to create_directory('/tmp/identity_attribute')
     end
   end
