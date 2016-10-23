.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A **directory** resource block declares a directory and the permissions needed on that directory. For example:

.. code-block:: ruby

   directory '/etc/apache2' do
     owner 'root'
     group 'root'
     mode '0755'
     action :create
   end

where

* ``'/etc/apache2'`` specifies the directory
* ``owner``, ``group``, and ``mode`` define the permissions

The full syntax for all of the properties that are available to the **directory** resource is:

.. code-block:: ruby

   directory 'name' do
     group                      String, Integer
     inherits                   TrueClass, FalseClass
     mode                       String, Integer
     notifies                   # see description
     owner                      String, Integer
     path                       String # defaults to 'name' if not specified
     provider                   Chef::Provider::Directory
     recursive                  TrueClass, FalseClass
     rights                     Hash
     subscribes                 # see description
     action                     Symbol # defaults to :create if not specified
   end

where 

* ``directory`` is the resource
* ``name`` is the name of the resource block; when the ``path`` property is not specified, ``name`` is also the path to the directory, from the root
* ``:action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``group``, ``inherits``, ``mode``, ``owner``, ``path``, ``provider``, ``recursive``, and ``rights`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.
