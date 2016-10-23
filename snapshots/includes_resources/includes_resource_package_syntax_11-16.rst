.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A **package** resource block manages a package on a node, typically by installing it. The simplest use of the **package** resource is:

.. code-block:: ruby

   package 'httpd'

which will install Apache using all of the default options and the default action (``:install``).

For a package that has different package names, depending on the platform, use a ``case`` statement within the **package**:

.. code-block:: ruby

   package 'Install Apache' do
     case node[:platform]
     when 'redhat', 'centos'
       package_name 'httpd'
     when 'ubuntu', 'debian'
       package_name 'apache2'
     end
   end

where ``'redhat', 'centos'`` will install Apache using the ``httpd`` package and ``'ubuntu', 'debian'`` will install it using the ``apache2`` package

The full syntax for all of the properties that are available to the **package** resource is:

.. code-block:: ruby

   package 'name' do
     allow_downgrade            TrueClass, FalseClass # Yum packages only
     arch                       String, Array # Yum packages only
     default_release            String # Apt packages only
     flush_cache                Array
     gem_binary                 String
     notifies                   # see description
     options                    String
     package_name               String, Array # defaults to 'name' if not specified
     provider                   Chef::Provider::Package
     response_file              String # Apt packages only
     response_file_variables    Hash # Apt packages only
     source                     String
     subscribes                 # see description
     timeout                    String, Integer
     version                    String, Array
     action                     Symbol # defaults to :install if not specified
   end

where 

* ``package`` tells the chef-client to manage a package; the chef-client will determine the correct package provider to use based on the platform running on the node
* ``'name'`` is the name of the package
* ``:action`` identifies which steps the chef-client will take to bring the node into the desired state
* ``allow_downgrade``, ``arch``, ``default_release``, ``flush_cache``, ``gem_binary``, ``options``, ``package_name``, ``provider``, ``response_file``, ``response_file_variables``, ``source``, ``recursive``, ``timeout``, and ``version`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.
