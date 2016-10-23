.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A **erl_call** resource block connects to a node located within a distributed Erlang system:

.. code-block:: ruby

   erl_call 'list names' do
     code 'net_adm:names().'
     distributed true
     node_name 'chef@latte'
   end

The full syntax for all of the properties that are available to the **erl_call** resource is:

.. code-block:: ruby

   erl_call 'name' do
     code                       String
     cookie                     String
     distributed                TrueClass, FalseClass
     name_type                  String
     node_name                  String
     notifies                   # see description
     provider                   Chef::Provider::ErlCall
     subscribes                 # see description
     action                     Symbol # defaults to :run if not specified
   end

where 

* ``erl_call`` is the resource
* ``name`` is the name of the resource block
* ``:action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``code``, ``cookie``, ``distributed``, ``name_type``, ``node_name``, and ``provider`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.
