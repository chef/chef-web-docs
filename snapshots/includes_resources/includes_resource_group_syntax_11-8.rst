.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A **group** resource block manages groups on a node:

.. code-block:: ruby

   group 'www-data' do
     action :modify
     members 'maintenance'
     append true
   end

The full syntax for all of the properties that are available to the **group** resource is:

.. code-block:: ruby

   group 'name' do
     append                     TrueClass, FalseClass
     gid                        String, Integer
     group_name                 String # defaults to 'name' if not specified
     members                    Array
     notifies                   # see description
     provider                   Chef::Provider::Group
     subscribes                 # see description
     system                     TrueClass, FalseClass
     action                     Symbol # defaults to :create if not specified
   end

where 

* ``group`` is the resource
* ``name`` is the name of the resource block
* ``:action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``append``, ``gid``, ``group_name``, ``members``, ``provider``, and ``system`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.
