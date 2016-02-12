.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


#. Open ``spec/unit/default.rb``.
#. Add:

   .. code-block:: ruby
   
      require 'chefspec'
      
      describe 'apache::default' do
        let(:chef_run) do
          ChefSpec::Runner.new.converge(described_recipe)
        end
      
        it 'installs apache' do
          expect(chef_run).to install_package('httpd')
        end
      end

#. Save the file.
