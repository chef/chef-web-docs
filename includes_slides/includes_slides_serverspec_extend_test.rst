.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


#. Open ``test/integration/default/serverspec/default_spec.rb``.
#. Add:

   .. code-block:: ruby
   
      describe 'apache' do
        it 'is installed' do
          expect(package 'httpd').to be_installed
        end
      
        it 'is running' do
          expect(service 'httpd').to be_running
        end
      
        it 'is listening on port 80' do
          expect(port 80).to be_listening
        end
      
        it 'displays a custom home page' do
          expect(command('curl localhost').stdout).to match /hello/
        end
      end

#. Save the file.
