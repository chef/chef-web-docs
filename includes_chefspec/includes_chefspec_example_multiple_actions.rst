.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


**Recipe**

.. code-block:: ruby

   service 'resource' do
     action :start
   end
   
   service 'resource' do
     action :nothing
   end

**Unit Test**

.. code-block:: ruby

   require 'chefspec'
   
   describe 'multiple_actions::sequential' do
     let(:chef_run) { ChefSpec::Runner.new(log_level: :fatal).converge(described_recipe) }
   
     it 'executes both actions' do
       expect(chef_run).to start_service('resource')
     end
   
     it 'does not match other actions' do
       expect(chef_run).to_not disable_service('resource')
     end
   end
