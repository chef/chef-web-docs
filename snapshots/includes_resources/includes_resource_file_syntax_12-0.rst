.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A **file** resource block manages files that exist on nodes. For example, to write the home page for an Apache website:

.. code-block:: ruby

   file '/var/www/customers/public_html/index.php' do
     content '<html>This is a placeholder for the home page.</html>'
     mode '0755'
     owner 'web_admin'
     group 'web_admin'
   end

where

* ``'/var/www/customers/public_html/index.php'`` is path to the file and also the filename to be managed
* ``content`` defines the contents of the file

The full syntax for all of the properties that are available to the **file** resource is:

.. code-block:: ruby

   file 'name' do
     atomic_update              TrueClass, FalseClass
     backup                     FalseClass, Integer
     checksum                   String
     content                    String
     force_unlink               TrueClass, FalseClass
     group                      String, Integer
     inherits                   TrueClass, FalseClass
     manage_symlink_source      TrueClass, FalseClass, NilClass
     mode                       String, Integer
     notifies                   # see description
     owner                      String, Integer
     path                       String # defaults to 'name' if not specified
     provider                   Chef::Provider::File
     rights                     Hash
     sensitive                  TrueClass, FalseClass
     subscribes                 # see description
     action                     Symbol # defaults to :create if not specified
   end

where 

* ``file`` is the resource
* ``name`` is the name of the resource block; when the ``path`` property is not specified as part of a recipe, ``name`` is also the path to the file
* ``content`` specifies the contents of the file
* ``:action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``atomic_update``, ``backup``, ``checksum``, ``content``, ``force_unlink``, ``group``, ``inherits``, ``manage_symlink_source``, ``mode``, ``owner``, ``path``, ``provider``, ``rights``, and ``sensitive`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.
