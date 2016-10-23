.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. THIS EXAMPLE IS DEPRECATED UNTIL THE Chef::ShellOut SECTION IS UPDATED FOR CORRECT Mixlib::ShellOut BEHAVIOR INCLUDING, BUT NOT LIMITED TO THE Chef::Application.fatal BIT BEING REMOVED ENTIRELY IN FAVOR OF SHELLOUT'S OWN ERROR HANDLING. WHEN UPDATED, ADD BACK INTO dsl_recipe_method_platform, resource_ruby_block, and dsl_recipe.

The following example shows how the ``platform?`` method and an if statement can be used in a recipe along with the ``ruby_block`` resource to run certain blocks of Ruby code on certain platforms:

.. code-block:: ruby

   if platform?('ubuntu', 'debian', 'redhat', 'centos', 'fedora', 'scientific', 'amazon')
     ruby_block 'update-java-alternatives' do
       block do
         if platform?('ubuntu', 'debian') and version == 6
           run_context = Chef::RunContext.new(node, {})
           r = Chef::Resource::Execute.new('update-java-alternatives', run_context)
           r.command 'update-java-alternatives -s java-6-openjdk'
           r.returns [0,2]
           r.run_action(:create)
         else

           require 'fileutils'
           arch = node['kernel']['machine'] =~ /x86_64/ ? 'x86_64' : 'i386'
           Chef::Log.debug("glob is #{java_home_parent}/java*#{version}*openjdk*")
           jdk_home = Dir.glob("#{java_home_parent}/java*#{version}*openjdk{,[-\.]#{arch}}")[0]
           Chef::Log.debug("jdk_home is #{jdk_home}")

           if File.exists? java_home
             FileUtils.rm_f java_home
           end
           FileUtils.ln_sf jdk_home, java_home

           cmd = Chef::ShellOut.new(
                 %Q[ update-alternatives --install /usr/bin/java java #{java_home}/bin/java 1;
                 update-alternatives --set java #{java_home}/bin/java ]
                 ).run_command
              unless cmd.exitstatus == 0 or cmd.exitstatus == 2
             Chef::Application.fatal!('Failed to update-alternatives for openjdk!')
           end
         end
       end
       action :nothing
     end
   end
