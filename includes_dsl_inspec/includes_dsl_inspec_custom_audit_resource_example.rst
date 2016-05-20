.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following example shows a full resource using attributes and methods to provide simple access to a configuration file:

.. code-block:: ruby

   class GordonConfig < Inspec.resource(1)
     name 'gordon_config'
   
     desc '
       Resource description ...
     '
   
     example '
       describe gordon_config do
         its("signal") { should eq "on" }
       end
     '
   
     # Load the configuration file on initialization
     def initialize(path = nil)
       @path = path || '/etc/gordon.conf'
       @params = SimpleConfig.new( read_content )
     end
   
     # Expose all parameters of the configuration file.
     def method_missing(name)
       @params[name]
     end
   
     private
   
     def read_content
       f = inspec.file(@path)
       # Test if the path exist and that it's a file
       if f.file?
         # Retrieve the file's contents
         f.content
       else
         # If the file doesn't exist, skip all tests that use gordon_config
         skip_resource "Can't read config from #{@path}."
       end
     end
   end

