.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A **remote_file** resource block manages files by using files that exist remotely. For example, to write the home page for an Apache website:

.. code-block:: ruby

   remote_file '/var/www/customers/public_html/index.php' do
     source 'http://somesite.com/index.php'
     owner 'web_admin'
     group 'web_admin'
     mode '0755'
     action :create
   end

where

* ``'/var/www/customers/public_html/index.php'`` is path to the file to be created
* ``'http://somesite.com/index.php'`` specifies the location of the remote file
* ``owner``, ``group``, and ``mode`` define the permissions

The full syntax for all of the properties that are available to the **cookbook_file** resource is:

.. code-block:: ruby

   remote_file 'name' do
     atomic_update              TrueClass, FalseClass
     backup                     FalseClass, Integer
     checksum                   String
     force_unlink               TrueClass, FalseClass
     ftp_active_mode            TrueClass, FalseClass
     group                      String, Integer
     headers                    Hash
     inherits                   TrueClass, FalseClass
     manage_symlink_source      TrueClass, FalseClass, NilClass
     mode                       String, Integer
     notifies                   # see description
     owner                      String, Integer
     path                       String # defaults to 'name' if not specified
     provider                   Chef::Provider::File::RemoteFile
     rights                     Hash
     source                     String, Array
     subscribes                 # see description
     use_conditional_get        TrueClass, FalseClass
     use_etag                   TrueClass, FalseClass
     use_last_modified          TrueClass, FalseClass
     action                     Symbol # defaults to :create if not specified
   end

where 

* ``remote_file`` is the resource
* ``name`` is the name of the resource block
* ``:action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``atomic_update``, ``backup``, ``checksum``, ``force_unlink``, ``ftp_active_mode``, ``group``, ``headers``, ``inherits``, ``manage_symlink_source``, ``mode``, ``owner``, ``path``, ``provider``, ``rights``, ``source``, ``use_conditional_get``, ``use_etag``, and ``use_last_modified`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.
