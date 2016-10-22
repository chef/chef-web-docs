.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A **env** resource block manages environment keys in Microsoft Windows:

.. code-block:: ruby

   env 'ComSpec' do
     value 'C:\\Windows\\system32\\cmd.exe'
   end

The full syntax for all of the properties that are available to the **env** resource is:

.. code-block:: ruby

   env 'name' do
     delim                      String
     key_name                   String # defaults to 'name' if not specified
     notifies                   # see description
     provider                   Chef::Provider::Env
     subscribes                 # see description
     value                      String
     action                     Symbol # defaults to :create if not specified
   end

where 

* ``env`` is the resource
* ``name`` is the name of the resource block
* ``:action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``delim``, ``key_name``, ``provider``, and ``value`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.
