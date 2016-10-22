.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A **cookbook_file** resource block manages files by using files that exist within a cookbook's ``/files`` directory. For example, to write the home page for an Apache website:

.. code-block:: ruby

   cookbook_file '/var/www/customers/public_html/index.php' do
     source 'index.php'
     owner 'web_admin'
     group 'web_admin'
     mode '0755'
     action :create
   end

where

* ``'/var/www/customers/public_html/index.php'`` is path to the file to be created
* ``'index.php'`` is a file in the ``/files`` directory in a cookbook that is used to create that file (the contents of the file in the cookbook will become the contents of the file on the node)
* ``owner``, ``group``, and ``mode`` define the permissions

The full syntax for all of the properties that are available to the **cookbook_file** resource is:

.. code-block:: ruby

   cookbook_file 'name' do
     atomic_update              TrueClass, FalseClass
     backup                     FalseClass, Integer
     cookbook                   String
     force_unlink               TrueClass, FalseClass
     group                      String, Integer
     inherits                   TrueClass, FalseClass
     manage_symlink_source      TrueClass, FalseClass, NilClass
     mode                       String, Integer
     notifies                   # see description
     owner                      String, Integer
     path                       String # defaults to 'name' if not specified
     provider                   Chef::Provider::CookbookFile
     rights                     Hash
     source                     String, Array
     subscribes                 # see description
     verify                     String, Block
     action                     Symbol # defaults to :create if not specified
   end

where 

* ``cookbook_file`` is the resource
* ``name`` is the name of the resource block
* ``:action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``atomic_update``, ``backup``, ``cookbook``, ``force_unlink``, ``group``, ``inherits``, ``manage_symlink_source``, ``mode``, ``owner``, ``path``, ``provider``, ``rights``, ``source``, and ``verify`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.
