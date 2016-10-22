.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A **template** resource block typically declares the location in which a file is to be created, the source template that will be used to create the file, and the permissions needed on that file. For example:

.. code-block:: ruby

   template '/etc/motd' do
     source 'motd.erb'
     owner 'root'
     group 'root'
     mode '0755'
   end

where

* ``'/etc/motd'`` specifies the location in which the file is created
* ``'motd.erb'`` specifies the name of a template that exists in in the ``/templates`` folder of a cookbook
* ``owner``, ``group``, and ``mode`` define the permissions

The full syntax for all of the properties that are available to the **template** resource is:

.. code-block:: ruby

   template 'name' do
     atomic_update              TrueClass, FalseClass
     backup                     FalseClass, Integer
     cookbook                   String
     force_unlink               TrueClass, FalseClass
     group                      String, Integer
     helper(:method)            Method { String } # see Helpers below
     helpers(module)            Module # see Helpers below
     inherits                   TrueClass, FalseClass
     local                      TrueClass, FalseClass
     manage_symlink_source      TrueClass, FalseClass, NilClass
     mode                       String, Integer
     notifies                   # see description
     owner                      String, Integer
     path                       String # defaults to 'name' if not specified
     provider                   Chef::Provider::File::Template
     rights                     Hash
     sensitive                  TrueClass, FalseClass
     source                     String, Array
     subscribes                 # see description
     variables                  Hash
     verify                     String, Block
     action                     Symbol # defaults to :create if not specified
   end

where 

* ``template`` is the resource
* ``name`` is the name of the resource block, typically the path to the location in which a file is created *and also* the name of the file to be managed. For example: ``/var/www/html/index.html``, where ``/var/www/html/`` is the fully qualified path to the location and ``index.html`` is the name of the file
* ``source`` is the template file that will be used to create the file on the node, for example: ``index.html.erb``; the template file is located in the ``/templates`` directory of a cookbook
* ``:action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``atomic_update``, ``backup``, ``cookbook``, ``force_unlink``, ``group``, ``helper``, ``helpers``, ``inherits``, ``local``, ``manage_symlink_source``, ``mode``, ``owner``, ``path``, ``provider``, ``rights``, ``sensitive``, ``source``, ``variables``, and ``verify`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.
