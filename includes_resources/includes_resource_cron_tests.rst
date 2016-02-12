.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|chef spec| is integrated into the |chef client| cookbook authoring workflow via the |chef dk|. The following examples show recipes and corresponding unit tests. See `ChefSpec <https://docs.chef.io/chefspec.html>`_ for more information about how to set up unit testing for resources in your cookbooks.

**Recipe**

.. code-block:: ruby

   cron 'default_action'

**Unit Test**

.. code-block:: ruby
   
   describe 'cron::create' do
     let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }
   end

or:

.. code-block:: ruby
   
   describe 'cron::create' do
     let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }
   
     it 'creates a cron with the default action' do
       expect(chef_run).to create_cron('default_action')
       expect(chef_run).to_not create_cron('not_default_action')
     end
   end

**Recipe**

.. code-block:: ruby

   cron 'explicit_action' do
     action :create
   end

**Unit Test**

.. code-block:: ruby
   
   describe 'cron::create' do
     let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }
   
     it 'creates a cron with an explicit action' do
       expect(chef_run).to create_cron('explicit_action')
     end
   end

**Recipe**

.. code-block:: ruby
   
   cron 'with_attributes' do
     minute '0'
     hour   '20'
   end

**Unit Test**

.. code-block:: ruby
   
   describe 'cron::create' do
     let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }
   
     it 'creates a cron with attributes' do
       expect(chef_run).to create_cron('with_attributes').with(minute: '0', hour: '20')
       expect(chef_run).to_not create_cron('with_attributes').with(minute: '10', hour: '30')
     end
   end