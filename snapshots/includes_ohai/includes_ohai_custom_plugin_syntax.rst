.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The syntax for an Ohai plugin is as follows:

.. code-block:: ruby

   Ohai.plugin(:Name) do
     include Ohai::Name
     provides 'attribute', 'attribute/subattribute'
     depends 'attribute', 'attribute'
     
     def shared_method
       # some Ruby code that defines the shared method
       attribute my_data
     end

     collect_data(:default) do
       # some Ruby code
       attribute my_data
     end

     collect_data(:platform...) do
       # some Ruby code that defines platform-specific requirements
       attribute my_data
     end

   end

where 

* Required. ``(:Name)`` is used to identify the plugin; when two plugins have the same ``(:Name)``, those plugins are joined together and run as if they were a single plugin. This value must be a valid Ruby class name, starting with a capital letter and containing only alphanumeric characters
* ``include`` is a standard Ruby method that allows an Ohai plugin to include a class, such as ``Ohai::Mixin::ModuleName``
* Required. ``provides`` is a comma-separated list of one (or more) attributes that are defined by this plugin. This attribute will become an automatic attribute (i.e. ``node[:attribute]``) after it is collected by Ohai at the start of the chef-client run. An attribute can also be defined using an ``attribute/subattribute`` pattern
* ``depends`` is a comma-separated list of one (or more) attributes that are collected by another plugin; as long as the value is collected by another Ohai plugin, it can be used by any plugin
* ``shared_method`` defines code that can be shared among one (or more) ``collect_data`` blocks; for example, instead of defining a mash for each ``collect_data`` block, the code can be defined as a shared method, and then called from any ``collect_data`` block
* ``collect_data`` is a block of Ruby code that is called by Ohai when it runs; one (or more) ``collect_data`` blocks can be defined in a plugin, but only a single ``collect_data`` block is ever run.
* ``collect_data(:default)`` is the code block that runs when a node's platform is not defined by a platform-specific ``collect_data`` block
* ``collect_data(:platform)`` is a platform-specific code block that is run when a match exists between the node's platform and this ``collect_data`` block; only one ``collect_data`` block may exist for each platform; possible values: ``:aix``, ``:darwin``, ``:freebsd``, ``:hpux``, ``:linux``, ``:openbsd``, ``:netbsd``, ``:solaris2``, ``:windows``, or any other value from ``RbConfig::CONFIG['host_os']``
* ``my_data`` is  string (``a string value``) or an empty mash (``{ :setting_a => 'value_a', :setting_b => 'value_b' }``). This is used to define the data that should be collected by the plugin

For example, the following plugin looks up data on virtual machines hosted in Amazon EC2, Google Compute Engine, Rackspace, Eucalyptus, Linode, OpenStack, and Microsoft Azure:

.. code-block:: ruby

   Ohai.plugin(:Cloud) do
     provides 'cloud'
   
     depends 'ec2'
     depends 'gce'
     depends 'rackspace'
     depends 'eucalyptus'
     depends 'linode'
     depends 'openstack'
     depends 'azure'
   
     def create_objects
       cloud Mash.new
       cloud[:public_ips] = Array.new
       cloud[:private_ips] = Array.new
     end
   
     ...
   
     def on_gce?
       gce != nil
     end
   
     def get_gce_values
       cloud[:public_ipv4] = []
       cloud[:local_ipv4] = []
   
       public_ips = gce['instance']['networkInterfaces'].collect do |interface|
         if interface.has_key?('accessConfigs')
           interface['accessConfigs'].collect{|ac| ac['externalIp']}
         end
       end.flatten.compact
   
       private_ips = gce['instance']['networkInterfaces'].collect do |interface|
         interface['ip']
       end.compact
       
       cloud[:public_ips] += public_ips
       cloud[:private_ips] += private_ips
       cloud[:public_ipv4] +=  public_ips
       cloud[:public_hostname] = nil
       cloud[:local_ipv4] += private_ips
       cloud[:local_hostname] = gce['instance']['hostname']
       cloud[:provider] = 'gce'
     end
   
     ...

     # with following similar code blocks for each cloud provider

where 

* ``provides`` defines the ``cloud`` attribute, which is then turned into an object using the ``create_objects`` shared method, which then generates a hash based on public or private IP addresses
* if the cloud provider is Google Compute Engine, then based on the IP address for the node, the ``cloud`` attribute data is populated into a hash

To see the rest of the code in this plugin, go to: https://github.com/chef/ohai/blob/master/lib/ohai/plugins/cloud.rb.
