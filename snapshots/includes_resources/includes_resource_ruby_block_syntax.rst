.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A **ruby_block** resource block executes a block of arbitrary Ruby code. For example, to reload the client.rb file during the chef-client run:

.. code-block:: ruby

   ruby_block 'reload_client_config' do
     block do
       Chef::Config.from_file("/etc/chef/client.rb")
     end
     action :run
   end

The full syntax for all of the properties that are available to the **ruby_block** resource is:

.. code-block:: ruby

   ruby_block 'name' do
     block                      Block
     block_name                 String # defaults to 'name' if not specified
     notifies                   # see description
     provider                   Chef::Provider::RubyBlock
     subscribes                 # see description
     action                     Symbol # defaults to :run if not specified
   end

where 

* ``ruby_block`` is the resource
* ``name`` is the name of the resource block
* ``block`` is the block of Ruby code to be executed
* ``:action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``block``, ``block_name``, and ``provider`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.
