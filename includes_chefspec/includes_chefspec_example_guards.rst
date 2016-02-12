.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


**Recipe**

.. code-block:: ruby

   service 'true_guard' do
     action  :start
     only_if { 1 == 1 }
   end
   
   service 'false_guard' do
     action :start
     not_if { 1 == 1 }
   end
   
   service 'action_nothing_guard' do
     action :nothing
   end

**Unit Test**

.. code-block:: ruby

   require 'chefspec'
   
   describe 'guards::default' do
     let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }
   
     it 'includes resource that have guards that evalute to true' do
       expect(chef_run).to start_service('true_guard')
     end
   
     it 'excludes resources that have guards evaluated to false' do
       expect(chef_run).to_not start_service('false_guard')
     end
   
     it 'excludes resource that have action :nothing' do
       expect(chef_run).to_not start_service('action_nothing_guard')
     end
   end
