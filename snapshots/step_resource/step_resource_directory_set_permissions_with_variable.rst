.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following example shows how read/write/execute permissions can be set using a variable named ``user_home``, and then for owners and groups on any matching node:

.. code-block:: ruby

   user_home = "/#{node[:matching_node][:user]}"
   
   directory user_home do
     owner 'node[:matching_node][:user]'
     group 'node[:matching_node][:group]'
     mode '0755'
     action :create
   end

where ``matching_node`` represents a type of node. For example, if the ``user_home`` variable specified ``{node[:nginx]...}``, a recipe might look similar to:

.. code-block:: ruby

   user_home = "/#{node[:nginx][:user]}"
   
   directory user_home do
     owner 'node[:nginx][:user]'
     group 'node[:nginx][:group]'
     mode '0755'
     action :create
   end
