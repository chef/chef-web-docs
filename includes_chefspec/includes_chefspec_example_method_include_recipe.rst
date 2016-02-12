.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


**Recipe**

.. code-block:: ruby

   include_recipe 'include_recipe::other'

**Unit Test**

.. code-block:: ruby

   require 'chefspec'

   describe 'include_recipe::default' do
     let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }
   
     it 'includes the `other` recipe' do
       expect(chef_run).to include_recipe('include_recipe::other')
     end
   
     it 'does not include the `not` recipe' do
       expect(chef_run).to_not include_recipe('include_recipe::not')
     end
   end
