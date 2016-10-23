.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A **mount** resource block manages a mounted file system:

.. code-block:: ruby

   mount node['mysql']['ec2_path'] do
     device ebs_vol_dev
     fstype 'xfs'
     action :mount
   end

The full syntax for all of the properties that are available to the **mount** resource is:

.. code-block:: ruby

   mount 'name' do
     device                     String
     device_type                Symbol
     domain                     String
     dump                       Integer, FalseClass
     enabled                    TrueClass, FalseClass
     fsck_device                String
     fstype                     String
     mount_point                String # defaults to 'name' if not specified
     mounted                    TrueClass, FalseClass
     notifies                   # see description
     options                    Array, String
     pass                       Integer, FalseClass
     password                   String
     provider                   Chef::Provider::Mount
     subscribes                 # see description
     supports                   Array
     username                   String
     action                     Symbol # defaults to :mount if not specified
   end

where 

* ``mount`` is the resource
* ``name`` is the name of the resource block
* ``:action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``device``, ``device_type``, ``domain``, ``dump``, ``enabled``, ``fsck_device``, ``fstype``, ``mount_point``, ``mounted``, ``options``, ``pass``, ``password``, ``provider``, ``supports``, and ``username`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.
