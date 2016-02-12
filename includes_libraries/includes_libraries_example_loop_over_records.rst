.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A customer record is stored in an attribute file that looks like this:

.. code-block:: ruby

   mycompany_customers({
     :bob => {
       :homedir => '/home/bob',
       :webdir => '/home/bob/web'
     }
   }
   )

If there are many customer records in an environment, a simple recipe can be used to loop over every customer, like this:

.. code-block:: ruby

   all_customers do |name, info|
     directory info[:webdir] do
       owner 'name'
       group 'name'
       action :create
     end
   end

A simple library could be created that extends ``Chef::Recipe::``, like this:

.. code-block:: ruby

   class Chef
     class Recipe
       def all_customers(&block)
         node[:mycompany_customers].each do |name, info|
           block.call(name, info)
         end
       end
     end
   end
