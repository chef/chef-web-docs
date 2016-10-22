.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following example uses the **file** resource to show the difference between it and what it would look like if it were a custom resource.

.. code-block:: ruby

   require 'chef/resource'
   
   class Chef
     class Resource
       class File < Chef::Resource
    
         def initialize(name, collection=nil, node=nil)
           super(name, collection, node)
           @resource_name = :file
           @path = name
           @backup = 5
           @action = 'create'
           @allowed_actions.push(:create, :delete, :touch, :create_if_missing)
         end
    
         def backup(arg=nil)
           set_or_return(
             :backup,
             arg,
             :kind_of => [ Integer, FalseClass ]
           )
         end
    
         def checksum(arg=nil)
           set_or_return(
             :checksum,
             arg,
             :regex => /^[a-zA-Z0-9]{64}$/
           )
         end
    
         def group(arg=nil)
           set_or_return(
             :group,
             arg,
             :regex => [ /^([a-z]|[A-Z]|[0-9]|_|-)+$/, /^\d+$/ ]
           )
         end
    
         def mode(arg=nil)
           set_or_return(
             :mode,
             arg,
             :regex => /^0?\d{3,4}$/
           )
         end
    
         def owner(arg=nil)
           set_or_return(
             :owner,
             arg,
             :regex => [ /^([a-z]|[A-Z]|[0-9]|_|-)+$/, /^\d+$/ ]
           )
         end
    
         def path(arg=nil)
           set_or_return(
             :path,
             arg,
             :kind_of => String
           )
         end
     
       end
     end
   end

The preceding code is simple, traditional Ruby. A number of getter/setter methods are created and inputs are validated against criteria, like regular expressions, strings, true/false, and so on. The custom resource looks like this:

.. code-block:: ruby

   actions :create, :delete, :touch, :create_if_missing
   
   attribute :backup,   :kind_of => [ Integer, FalseClass ]
   attribute :group,    :regex => [ /^([a-z]|[A-Z]|[0-9]|_|-)+$/, /^\d+$/ ]
   attribute :mode,     :regex => /^0?\d{3,4}$/
   attribute :owner,    :regex => [ /^([a-z]|[A-Z]|[0-9]|_|-)+$/, /^\d+$/ ]
   attribute :path,     :kind_of => String
   attribute :checksum, :regex => /^[a-zA-Z0-9]{64}$/

What this shows are the similarities and differences between resources and custom resources. The custom resources are easier to write and understand, plus they can offer much the same (if not identical) functionality as the more complex platform resources.
