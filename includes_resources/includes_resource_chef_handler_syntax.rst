.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A |resource chef_handler| resource block enables handlers during a |chef client| run. Two handlers---``JsonFile`` and ``ErrorReport``---are built into |chef|:

.. code-block:: ruby

   chef_handler 'Chef::Handler::JsonFile' do
     source 'chef/handler/json_file'
     arguments :path => '/var/chef/reports'
     action :enable
   end

and:

.. code-block:: ruby

   chef_handler 'Chef::Handler::ErrorReport' do
     source 'chef/handler/error_report'
     action :enable
   end

show how to enable those handlers in a recipe.

The full syntax for all of the properties that are available to the |resource chef_handler| resource is:

.. code-block:: ruby

   chef_handler 'name' do
     arguments                  Array
     class_name                 String
     notifies                   # see description
     source                     String
     subscribes                 # see description
     supports                   Hash
     action                     Symbol
   end

where 

* ``chef_handler`` is the resource
* ``name`` is the name of the resource block
* ``:action`` identifies the steps the |chef client| will take to bring the node into the desired state
* ``arguments``, ``class_name``, ``source``, and ``supports`` are properties of this resource, with the |ruby| type shown. |see attributes|
