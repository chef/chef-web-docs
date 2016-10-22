.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A **user** resource block manages users on a node:

.. code-block:: ruby

   user 'a user' do
     comment 'A random user'
     uid '1234'
     gid '1234'
     home '/home/random'
     shell '/bin/bash'
     password '$1$JJsvHslasdfjVEroftprNn4JHtDi'
   end

The full syntax for all of the properties that are available to the **user** resource is:

.. code-block:: ruby

   user 'name' do
     comment                    String
     force                      TrueClass, FalseClass # see description
     gid                        String, Integer
     home                       String
     manage_home                TrueClass, FalseClass
     non_unique                 TrueClass, FalseClass
     notifies                   # see description
     password                   String
     provider                   Chef::Provider::User
     shell                      String
     subscribes                 # see description
     system                     TrueClass, FalseClass
     uid                        String, Integer
     username                   String # defaults to 'name' if not specified
     action                     Symbol # defaults to :create if not specified
   end

where 

* ``user`` is the resource
* ``name`` is the name of the resource block
* ``:action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``comment``, ``force``, ``gid``, ``home``, ``manage_home``, ``non_unique``, ``password``, ``provider``, ``shell``, ``system``, ``uid``, and ``username`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.
